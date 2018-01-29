Received: from eggs.gnu.org ([2001:4830:134:3::10]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg7kz-0004Hv-7F
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg7ky-0002wT-6L
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:37:49 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eg7kx-0002wD-Vj
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:37:48 -0500
Received: by mail-ot0-x244.google.com with SMTP id r4so6207490oti.12
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 03:37:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 11:37:26 +0000
Message-ID: <CAFEAcA_aOF-Dz_Ji0AVfi=CHvb7GoKSmOAsCGmA5b5bYn4bKFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Merge tpm 2018/01/26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 26 January 2018 at 18:49, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The patches in this pull request fix a bug in the initialization of
> a variable, adapt the cancel path used by the passthrough device to the
> sysfs path of more recent versions of the Linux kernel, and do some other
> cleanups preparing for support of migration. Finally, we add the CRB
> interface emulation, which is used with a TPM 2.
>
>    Stefan
>
> The following changes since commit 0f79bfe38a2cf0f43c7ea4959da7f8ebd7858f3d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-pull-request' into staging (2018-01-25 09:53:53 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-01-26-1
>
> for you to fetch changes up to b510b21e072a0a9218f37051c885e95824d06bea:
>
>   tpm: add CRB device (2018-01-26 10:12:02 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2018/01/26 v1
>
> ----------------------------------------------------------------

Hi. The new tpm-crb-test fails on sparc host:

TEST: tests/tpm-crb-test... (pid=230409)
  /i386/tpm-crb/test:
Broken pipe
FAIL
GTester: last random seed: R02S29cea50247fe1efa59ee885a26d51a85
(pid=230423)
FAIL: tests/tpm-crb-test

and generates a new clang sanitizer runtime warning:

/home/petmay01/linaro/qemu-for-merges/hw/tpm/tpm_util.h:36:24: runtime
error: load of misaligned address 0x7fdc24c00002 for type 'const
uint32_t' (aka 'const unsigned int'), which requires 4 byte alignment
0x7fdc24c00002: note: pointer points here
<memory cannot be printed>

Chances are good these are the same thing, because the sparc architecture
does not allow misaligned loads and will segfault if you try them.
This function looks like it's the immediate culprit:

static inline uint32_t tpm_cmd_get_size(const void *b)
{
    return be32_to_cpu(*(const uint32_t *)(b + 2));
}

I suspect that this function should read
    return ldl_be_p(b + 2);

This is likely not the only problem with misaligned data in the
tpm code -- for instance the cast here in tpm_util_is_selftest()
looks odd:

bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len)
{
    struct tpm_req_hdr *hdr = (struct tpm_req_hdr *)in;

As a general rule you can't take an arbitrary pointer into a byte
buffer and try to interpret it as a structure or a pointer to
a larger-than-bytesize-data simply by casting the pointer.
It might be worth reviewing all the tpm code for bugs
of this nature.

thanks
-- PMM
