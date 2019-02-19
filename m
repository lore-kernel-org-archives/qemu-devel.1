Received: from eggs.gnu.org ([209.51.188.92]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gw6IT-0005GZ-0o
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gw6IO-0005IH-Hf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:22:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gw6IN-00059h-HL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:22:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id r5so8818891wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:22:40 -0800 (PST)
References: <20190215143115.28777-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190215143115.28777-1-alex.bennee@linaro.org>
Date: Tue, 19 Feb 2019 14:22:37 +0000
Message-ID: <87d0nn6eoi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH  v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, mark.cave-ayland@ilande.co.uk


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This is hopefully the final version of the softmmu demacro series. I
> tracked down the remaining failures to:
>
>   - not always using the correct victim tlb
>   - not masking reads when we unrolled the unaligned helpers
>
> Other than that I've rolled in the changes that were made to support
> dynamic TLB code and the follow-up fixes. All patches need some review
> before we can merge them.

Measurements:

Before

hyperfine -w 2 './aarch64-softmmu/qemu-system-aarch64 -machine virt,graphic=
s=3Don,gic-version=3D3,virtualization=3Don -cpu cortex-a53 -serial mon:stdi=
o -nic user,model=3Dvirtio-net-
pci,hostfwd=3Dtcp::2222-:22 -device virtio-scsi-pci -device scsi-hd,drive=
=3Dhd0 -blockdev driver=3Draw,node-name=3Dhd0,discard=3Dunmap,file.driver=
=3Dhost_device,file.filename=3D/dev/zvol/
hackpool-0/debian-buster-arm64 -kernel ../linux.git/builds/arm64.nopreempt/=
arch/arm64/boot/Image -append "console=3DttyAMA0 root=3D/dev/sda2 systemd.u=
nit=3Dbenchmark-pigz.service"
 -display none -m 8192 -smp 4 --snapshot'
Benchmark #1: ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=
=3Don,gic-version=3D3,virtualization=3Don -cpu cortex-a53 -serial mon:stdio=
 -nic user,model=3Dvirtio-net-pci,hostfwd=3Dtcp::2222-:22 -device virtio-sc=
si-pci -device scsi-hd,drive=3Dhd0 -blockdev driver=3Draw,node-name=3Dhd0,d=
iscard=3Dunmap,file.driver=3Dhost_device,file.filename=3D/dev/zvol/hackpool=
-0/debian-buster-arm64 -kernel ../linux.git/builds/arm64.nopreempt/arch/arm=
64/boot/Image -append "console=3DttyAMA0 root=3D/dev/sda2 systemd.unit=3Dbe=
nchmark-pigz.service" -display none -m 8192 -smp 4 --snapshot
  Time (mean =C2=B1 =CF=83):     66.035 s =C2=B1  1.425 s    [User: 241.495=
 s, System: 2.327 s]
  Range (min =E2=80=A6 max):   64.718 s =E2=80=A6 68.944 s    10 runs

After

hyperfine -w 2 './aarch64-softmmu/qemu-system-aarch64 -machine virt,graphic=
s=3Don,gic-version=3D3,virtualization=3Don -cpu cortex-a53 -serial mon:stdi=
o -nic user,model=3Dvirtio-net-pci,hostfwd=3Dtcp::2222-:22 -device virtio-s=
csi-pci -device scsi-hd,drive=3Dhd0 -blockdev driver=3Draw,node-name=3Dhd0,=
discard=3Dunmap,file.driver=3Dhost_device,file.filename=3D/dev/zvol/hackpoo=
l-0/debian-buster-arm64 -kernel ../linux.git/builds/arm64.nopreempt/arch/ar=
m64/boot/Image -append "console=3DttyAMA0 root=3D/dev/sda2 systemd.unit=3Db=
enchmark-pigz.service" -display none -m 8192 -smp 4 --snapshot'
Benchmark #1: ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=
=3Don,gic-version=3D3,virtualization=3Don -cpu cortex-a53 -serial mon:stdio=
 -nic user,model=3Dvirtio-net-pci,hostfwd=3Dtcp::2222-:22 -device virtio-sc=
si-pci -device scsi-hd,drive=3Dhd0 -blockdev driver=3Draw,node-name=3Dhd0,d=
iscard=3Dunmap,file.driver=3Dhost_device,file.filename=3D/dev/zvol/hackpool=
-0/debian-buster-arm64 -kernel ../linux.git/builds/arm64.nopreempt/arch/arm=
64/boot/Image -append "console=3DttyAMA0 root=3D/dev/sda2 systemd.unit=3Dbe=
nchmark-pigz.service" -display none -m 8192 -smp 4 --snapshot
  Time (mean =C2=B1 =CF=83):     65.331 s =C2=B1  0.684 s    [User: 240.528=
 s, System: 2.306 s]
  Range (min =E2=80=A6 max):   64.624 s =E2=80=A6 66.914 s    10 runs

Although I'm not going to claim a performance boost, just that it's in
the noise.

Emilio,

Any chance you could run it through your benchmark suite?

>
> Alex Benn=C3=A9e (3):
>   accel/tcg: demacro cputlb
>   accel/tcg: remove softmmu_template.h
>   accel/tcg: move unaligned helpers out of core helpers
>
>  accel/tcg/cputlb.c           | 501 +++++++++++++++++++++++++++++++++--
>  accel/tcg/softmmu_template.h | 454 -------------------------------
>  2 files changed, 475 insertions(+), 480 deletions(-)
>  delete mode 100644 accel/tcg/softmmu_template.h


--
Alex Benn=C3=A9e
