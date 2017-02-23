Received: from eggs.gnu.org ([2001:4830:134:3::10]:41976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgsnL-0001xs-9c
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgsnK-0001qZ-Cf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:46:51 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgsnK-0001qO-5C
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:46:50 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so170680812wmd.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 04:46:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 12:46:28 +0000
Message-ID: <CAFEAcA_G=KNQSitea9sE1pfDDZA7tR9zqFKbm-0KASaT6v6kag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 February 2017 at 00:21, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> Hi,
>
> This is the v2 of the pull-req for target-mips.
> The warning treated as error has been fixed and the file is now isolated for mips64el only.
> Boston has further update to have default -drive to if=ide.
>
> Regards,
> Yongbok
>
> The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170222
>
> for you to fetch changes up to d3473e147a754e999718bf6fcb015d9978c6a1ee:
>
>   hw/mips: MIPS Boston board support (2017-02-21 23:49:30 +0000)
>
> ----------------------------------------------------------------
> MIPS patches 2017-02-22
>
> Changes:
> * Add MIPS Boston board support

This seems to cause a lot of new clang sanitizer warnings:
/home/petmay01/linaro/qemu-for-merges/dtc/libfdt/fdt_rw.c:288:21:
runtime error: null pointer passed as argument 2, which is declared to
never be null

which are all for the memcpy() in fdt_setprop() when fdt_setprop()
is passed a NULL pointer.

On the other hand the implementation of fdt_setprop() hasn't changed
in years so I'm not quite sure why this warning is only showing up
now. It may be that the clang build used to pull in system libfdt
but now has built its own.

On that basis I've pushed this to master and we'll figure out
the sanitizer issues separately.

Please make sure you update the 'Build dependencies' section of
http://wiki.qemu-project.org/ChangeLog/2.9
to flag up the new libfdt version dependency to users.

thanks
-- PMM
