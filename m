Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbY0W-0004Vc-AG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbY0S-0008Eu-4o
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:34:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbY0R-0008En-Sz
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:34:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC8EBC05AA41
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 19:34:19 +0000 (UTC)
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
	<1486579756.3641.30.camel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7952cdc6-9852-7a5e-27bd-2d2d1a859866@redhat.com>
Date: Wed, 8 Feb 2017 20:34:16 +0100
MIME-Version: 1.0
In-Reply-To: <1486579756.3641.30.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com

On 02/08/17 19:49, Andrea Bolognani wrote:
> On Wed, 2017-02-08 at 19:11 +0100, Laszlo Ersek wrote:
>> How about:
>>  
>>    For any new guest, its permanent, private variable store should
>>    initially be copied from the template file provided as part of the
>>    ArmVirtQemu firmware platform (which is occasionally distributed
>>    under the AAVMF package).
> 
> The naming is confusing enough as it is, no need to drag
> ArmVirtQemu into this I think ;)

Yeah, that's the upstream platform name, and I know that Leif and Ard
dislike "AAVMF". In downstream, we needed some name for the package,
when -- if memory serves -- upstream was still called
"ArmPlatformPkg/ArmVirtualizationPkg", and there was no Xen support,
only QEMU, so QEMU wasn't even in the name, because it was implied.

We agreed upon "AAVMF" (don't say anything), and of course the name
percolated to the outside, via mailing lists, other projects that
embedded the name (libguestfs, maybe?), and so on.

> 
>>> +# Fedora:
>>> +#   /usr/share/edk2/aarch64/QEMU_EFI.fd
>>> +#   /usr/share/edk2/aarch64/QEMU_VARS.fd
>>  
>> Please annotate each as firmware binary & variable store template.
> 
> I had such annotations at some points, I got rid of them
> because they seemed a bit redundant. Added them back in.
> 
>> Also, I can't verify the exact pathnames for Fedora.
> 
> https://koji.fedoraproject.org/koji/rpminfo?rpmID=8491933 ;)

Ahhh, it's *very* good that you provided this reference, because now I
see that the file names below are incorrect. Namely, for aarch64 guests,
you have to use the files that are padded to 64MB, *not* the files as
they fall out of the edk2 build process.

> 
> [...]
>>> +# RHEL:
>>> +#   /usr/share/AAVMF/AAVMF_CODE.fd
>>> +#   /usr/share/AAVMF/AAVMF_VARS.fd
>>  
>> Looks legit. (Might want to call "RHEL" "RHELSA" though, in this context
>> -- no clue. Ask Drew :))
> 
> Yeah, you're probably right.
> 
> [...]
>> Please expand the comment:
>>  
>>    CHANGE ME TO THE NAME OF THE FILE THAT YOU CREATED AS A COPY of THE
>>    VARSTORE TEMPLATE
> 
> Nope. The line would get waaay too long, and I trust the
> user

Good for you :)

> to understand the basic idea after having gone through
> the paragraphs above.

Okay ;)

> 
> Here's an updated version, what do you think about it?
> 
> 
> # Firmware configuration
> # =========================================================
> #
> # There are two parts to the firmware: a read-only image
> # containing the executable code, which is shared between
> # guests, and a read/write variable store that is owned
> # by one specific guest, exclusively, and is used to record
> # information such as the UEFI boot order.
> #
> # For any new guest, its permanent, private variable store
> # should initially be copied from the template file
> # provided along with the firmware binary.
> #
> # Depending on the OS distribution you're using on the
> # host, the name of the package containing the firmware
> # binary and variable store, as well as the paths to the

red flag: please say "variable store *template*"

> # files themselves, will be different. Some examples:
> #
> # Fedora:
> #   edk2-aarch64                          (package)
> #   /usr/share/edk2/aarch64/QEMU_EFI.fd   (binary)
> #   /usr/share/edk2/aarch64/QEMU_VARS.fd  (template)
> #
> # RHELSA:
> #   AAVMF                                 (package)
> #   /usr/share/AAVMF/AAVMF_CODE.fd        (binary)
> #   /usr/share/AAVMF/AAVMF_VARS.fd        (varstore)

Two comments:

- Under Fedora, you have (template), which is cool, (varstore) is bad. :)

- Again, the files you note above for Fedora are 2MB and 768KB in size,
respectively, which is wrong. The files you note for RHELSA are both
64MB in size, which is right. Fedora ships the according files as well,
but their names are different:

/usr/share/edk2/aarch64/QEMU_EFI-pflash.raw      (binary)
/usr/share/edk2/aarch64/vars-template-pflash.raw (varstore template)

Thanks!
Laszlo

> 
> -- 
> Andrea Bolognani / Red Hat / Virtualization
> 
