Received: from eggs.gnu.org ([2001:4830:134:3::10]:37066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7VX-0001vE-CI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7VU-0008Pa-AN
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL7VU-0008Ol-3q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:34:44 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41757d38-5fdb-befa-e385-69cc7b02ee6f@redhat.com>
Date: Wed, 14 Jun 2017 14:34:38 +0200
MIME-Version: 1.0
In-Reply-To: <1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/4] fw_cfg: don't map the fw_cfg IO
 ports in fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, rjones@redhat.com, peter.maydell@linaro.org



On 12/06/2017 23:21, Mark Cave-Ayland wrote:
> As indicated by Laszlo it is a QOM bug for the realize() method to actually
> map the device. Set up the IO regions with sysbus_init_mmio() and defer
> the mapping to the caller, as already done in fw_cfg_init_mem_wide().

... sort of.

The idea is that the ISA bridge (including all the legacy I/O devices,
of which fw_cfg part) does subtractive decoding, i.e. "if nobody else
wants it, I'll take it".  So that's why fw_cfg's realize() maps I/O
ports, and why the API is sysbus_add_io.

Sysbus MMIO maps a different hardware concept, where the "base" is
decoded by the SoC and forwarded to the component at that address.  This
is represented by the sysbus_init_mmio/sysbus_mmio_map pair.

Documentation for this would be welcome, but sysbus.h doesn't have many
function comments. :(

Paolo
