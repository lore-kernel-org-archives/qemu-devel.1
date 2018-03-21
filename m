Received: from eggs.gnu.org ([2001:4830:134:3::10]:49815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyihg-0007Dj-J9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyihd-0000dF-GJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:43:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyihd-0000cN-B4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:43:13 -0400
Date: Wed, 21 Mar 2018 18:42:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180321184259.GI3465@work-vm>
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521253498-6834-4-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521253498-6834-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5.2 for 2.13 3/4] docs: tpm: add VM
 save/restore example and troubleshooting guide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

* Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> Extend the docs related to TPM with specs related to VM save and
> restore and a troubleshooting guide for TPM migration.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

This seems ok, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

but comments below:

> ---
>  docs/specs/tpm.txt | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index d1d7157..c230c4c 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -200,3 +200,109 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
>  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>  ...
>  PCR-23: 00 00 00 00 00 00 00 00 ...
> +
> +
> +=== Migration with the TPM emulator ===
> +
> +The TPM emulator supports the following types of virtual machine migration:
> +
> +- VM save / restore (migration into a file)
> +- Network migration
> +- Snapshotting (migration into storage like QoW2 or QED)
> +
> +The following command sequences can be used to test VM save / restore.
> +
> +
> +In a 1st terminal start an instance of a swtpm using the following command:
> +
> +mkdir /tmp/mytpm1
> +swtpm socket --tpmstate dir=/tmp/mytpm1 \
> +  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> +  --log level=20 --tpm2
> +
> +In a 2nd terminal start the VM:
> +
> +qemu-system-x86_64 -display sdl -enable-kvm \
> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
> +  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +  -device tpm-tis,tpmdev=tpm0 \
> +  -monitor stdio \
> +  test.img
> +
> +Verify that the attached TPM is working as expected using applications inside
> +the VM.
> +
> +To store the state of the VM use the following command in the QEMU monitor in
> +the 2nd terminal:
> +
> +(qemu) migrate "exec:cat > testvm.bin"
> +(qemu) quit
> +
> +At this point a file called 'testvm.bin' should exists and the swtpm and QEMU
> +processes should have ended.
> +
> +To test 'VM restore' you have to start the swtpm with the same parameters
> +as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now be
> +passed again on the command line.
> +
> +In the 1st terminal restart the swtpm with the same command line as before:
> +
> +swtpm socket --tpmstate dir=/tmp/mytpm1 \
> +  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> +  --log level=20 --tpm2
> +
> +In the 2nd terminal restore the state of the VM using the additonal
> +'-incoming' option.
> +
> +qemu-system-x86_64 -display sdl -enable-kvm \
> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
> +  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +  -device tpm-tis,tpmdev=tpm0 \
> +  -incoming "exec:cat < testvm.bin" \
> +  test.img
> +
> +
> +Troubleshooting migration:
> +
> +There are several reasons why migration may fail. In case of problems,
> +please ensure that the command lines adhere to the following rules and,
> +if possible, that identical versions of QEMU and swtpm are used at all
> +times.
> +
> +VM save and restore:
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on VM restore
> + - swtpm command line parameters should be identical
> +
> +VM migration to 'localhost':
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on the destination side
> + - swtpm command line parameters should point to two different
> +   directories on the source and destination swtpm (--tpmstate dir=...)
> +   (especially if different versions of libtpms were to be used on the
> +   same machine).
> +
> +VM migration across the network:
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on the destination side
> + - swtpm command line parameters should be identical
> +
> +VM Snapshotting:
> + - QEMU command line parameters should be identical

Well, they don't actually need to be identical; they just need to be
identically configured as far as the state goes.  For example all the
paths to storage can be completely different on the two QEMUs.

> + - swtpm command line parameters should be identical
> +
> +
> +Besides that, migration failure reasons on the swtpm level may include
> +the following:
> +
> + - the versions of the swtpm on the source and destination sides are
> +   incompatible
> +   - downgrading of TPM state may not be supported
> +   - the source and destination libtpms were compiled with different
> +     compile-time options and the destination side refuses to accept the
> +     state
> + - different migration keys are used on the source and destination side
> +   and the destination side cannot decrypt the migrated state
> +   (swtpm ... --migration-key ... )

Are there particular error messages swtpm will produce in these cases
to make it easy for people to tell which has happened?

Dave

> -- 
> 2.5.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
