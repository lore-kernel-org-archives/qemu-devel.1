Received: from eggs.gnu.org ([2001:4830:134:3::10]:35323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHAZ7-00060F-RZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHAZ3-000059-PE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:38:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gHAZ3-00004y-Ii
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:38:53 -0400
Date: Mon, 29 Oct 2018 12:38:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181029163850.GC17805@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-49-cota@braap.org>
	<000b01d46f76$67926b20$36b74160$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01d46f76$67926b20$36b74160$@ru>
Subject: Re: [Qemu-devel] [RFC 48/48] plugin: add a couple of very simple
 examples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?'Llu=EDs?= Vilanova' <vilanova@ac.upc.edu>, 'Peter Maydell' <peter.maydell@linaro.org>, 'Alex =?iso-8859-1?Q?Benn=E9e'?= <alex.bennee@linaro.org>, 'Stefan Hajnoczi' <stefanha@gmail.com>

On Mon, Oct 29, 2018 at 13:59:03 +0300, Pavel Dovgalyuk wrote:
> > From: Emilio G. Cota [mailto:cota@braap.org]
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
(snip)
> Thanks for the series.
> Can you provide more plugin examples for better understanding of double-translate idea?
> E.g., plugins that hook specific instructions or addresses.

Here's a plugin that at TB translation time, disassembles the
instructions provided via capstone. It doesn't do anything
with that info (vcpu_tb_exec is empty), but say a simulator
would pass via the *udata pointer some descriptor (allocated
at translation time) based on the instructions in the TB.

Note that the disassembly happens because we already have
a fully formed TB thanks to the 2-pass translation. Without it,
we'd have to (1) perform additional loads in the guest to read
instructions given the PC, and (2) guess when the TB would end
(recall that when to finish a TB is a decision internal to QEMU).

Thanks,

		Emilio

PS. Compile with -lcapstone
---
#include <inttypes.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>

#include <capstone/capstone.h>
#include <qemu-plugin.h>

struct tb {
	size_t n_insns;
};

static csh cap_handle;
static cs_insn *cap_insn;

static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
		     uint64_t vaddr, void *udata)
{ }

static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
{ }

static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index, struct qemu_plugin_tb *tb)
{
	struct tb *desc;
	size_t n = qemu_plugin_tb_n_insns(tb);
	size_t i;

	for (i = 0; i < n; i++) {
		struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
		size_t size = qemu_plugin_insn_size(insn);
		const uint8_t *code = qemu_plugin_insn_data(insn);
		uint64_t offset = 0;
		bool success;

		success = cs_disasm_iter(cap_handle, &code, &size, &offset, cap_insn);
		assert(success);
		qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
						 QEMU_PLUGIN_CB_NO_REGS, NULL);
	}
	desc = malloc(sizeof(*desc));
	assert(desc);
	desc->n_insns = n;

	qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
					     QEMU_PLUGIN_CB_NO_REGS, desc);
}

QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc, char **argv)
{
	if (cs_open(CS_ARCH_X86, CS_MODE_64, &cap_handle) != CS_ERR_OK) {
		return -1;
	}
	cap_insn = cs_malloc(cap_handle);
	if (cap_insn == NULL) {
		return -1;
	}
	qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
	return 0;
}
