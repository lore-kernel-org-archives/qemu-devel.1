Received: from eggs.gnu.org ([2001:4830:134:3::10]:49771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW8BR-0003T9-1c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW8BO-0001u2-CT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dW8BO-0001tB-33
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:31:30 -0400
References: <eef9a031-36e9-0443-1d73-30a49df02e9a@redhat.com>
	<20170714203044.lplfddes2wvn2oco@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9022a9e6-7c0c-e6e4-d603-a391c2d447ec@redhat.com>
Date: Fri, 14 Jul 2017 23:31:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170714203044.lplfddes2wvn2oco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [edk2] investigating TPM for OVMF-on-QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Jones <pjones@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, edk2-devel-01 <edk2-devel@lists.01.org>, Javier Martinez Canillas <javierm@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Jiewen Yao <jiewen.yao@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/14/17 22:30, Peter Jones wrote:
> On Fri, Jul 14, 2017 at 08:04:14PM +0200, Laszlo Ersek wrote:

>> (2e) Modules that we should use. Again, in increasing order of
>>      dependence. And here I'll comment as well on what these do:
>>
>>        Tcg2Config/Tcg2ConfigPei.inf -- Informs the firmware globally
>>                                        about the TPM device type. This
>>                                        module can perform device
>>                                        detection or read a cached value
>>                                        from a non-volatile UEFI
>>                                        variable.
>>
>>        Tcg2Pei/Tcg2Pei.inf          -- Initializes the TPM device and
>>                                        measures the firmware volumes in
>>                                        the PEI phase into the TPM's
>>                                        platform config registers.
>>
>>        Tcg2Dxe/Tcg2Dxe.inf          -- Measures DXE phase (and later)
>>                                        modules into the TPM's PCRs, and
>>                                        also lets the OS boot loader
>>                                        measure things, by exposing the
>>                                        EFI_TCG2_PROTOCOL.
>>
>>        Tcg2Config/Tcg2ConfigDxe.inf -- Provides a Setup TUI interface to
>>                                        configure the TPM. IIUC, it can
>>                                        also save the configured TPM type
>>                                        for subsequent boots (see
>>                                        Tcg2ConfigPei.inf above).
>>
>>      This driver stack supports the TIS (MMIO) hardware interface, which
>>      is advertized to the OS in the TPM2 ACPI Table's "start method"
>>      field with value 6. (The according macro is TPM2_START_METHOD_MMIO
>>      in the QEMU source code, and EFI_TPM2_ACPI_TABLE_START_METHOD_TIS
>>      in the edk2 source code.)
>>
>>      Including these drivers should result in a functional
>>      EFI_TCG2_PROTOCOL, which is what OS boot loaders primarily care
>>      about, as I understand.
>>
>>      Importantly, the driver stack above requires PEI-phase variable
>>      access, therefore
>>      <https://bugzilla.tianocore.org/show_bug.cgi?id=386> must be solved
>>      first.
>>
>>      (I have had patches for said BZ ready for a while. I've failed to
>>      upstream them thus far because a pflash-based varstore is a hard
>>      requirement for them. I think that's a natural requirement, but
>>      thus far my arguments haven't proved compelling enough.)
>
> It does seem pretty natural... what's the counter argument?

Jordan holds the opinion that "we should continue to support the memory
vars, even if they have some obvious drawbacks":

http://mid.mail-archive.com/149065122031.28789.9113394760317457361@jljusten-skl

I'm of a different opinion: while I agree that we should not break the
existing memory emulation, I'm also convinced that we should not develop
new features for it, especially when a new feature (such as PEI-phase
R/O variable access) simply cannot be *sensibly* extended to said
emulation.

Please see the first discussion under my original patch set:

http://mid.mail-archive.com/148969026858.27582.5519307275216644796@jljusten-skl.jf.intel.com
http://mid.mail-archive.com/319ff8f1-4e99-f977-5c2e-75509a222706@redhat.com
http://mid.mail-archive.com/c20c6604-2153-aa57-cee5-24089a79b1e9@redhat.com
http://mid.mail-archive.com/149034108785.2439.14733776608486243050@jljusten-skl
http://mid.mail-archive.com/4b06b195-d8fb-a33e-3492-74fe396ebf6e@redhat.com

And the second discussion under Jordan's counter-proposal:

http://mid.mail-archive.com/a12bbf61-3f55-2fda-b855-58aeb99a4f42@redhat.com
http://mid.mail-archive.com/149065122031.28789.9113394760317457361@jljusten-skl
http://mid.mail-archive.com/121bb81b-08d1-d854-cf6f-ebc8268eb360@redhat.com
http://mid.mail-archive.com/149076505135.12962.12298731900768295093@jljusten-skl

Thanks
Laszlo
