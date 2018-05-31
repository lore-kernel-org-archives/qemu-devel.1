Received: from eggs.gnu.org ([2001:4830:134:3::10]:37157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fORYj-00004x-HB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fORYi-0003hj-Gp
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:40:21 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fORYi-0003gg-9s
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:40:20 -0400
Received: by mail-pl0-x236.google.com with SMTP id z9-v6so10306201plk.11
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 10:40:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531192619.62550340@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<033ba6f2e3f0daccb31e1930a1c65cf7a18ae66c.1527310210.git.keno@alumni.harvard.edu>
	<20180529203426.3aa6305a@bahia.lan>
	<CABV8kRzhiVy9ix67OfPcSZ-SNa6Zh6j5uZ05-yhKW_=Ujyd1HQ@mail.gmail.com>
	<20180531192619.62550340@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 13:39:38 -0400
Message-ID: <CABV8kRy0+6tt9_UEJRZP1=9p4O_mqFuU3XZ0QwL_tbiN9D_=5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/13] 9p: Move a couple xattr functions to
 9p-util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

> Oops you're right... so we indeed need to handle this conflicting APIs,
> but fgetxattr_follow() is inapropriate, because fgetxattr() has nothing
> to follow since it already has an fd... The same goes with Darwin's
> version actually. The "nofollow" thingy only makes sense for those calls
> that have a dirfd and pathname argument.
>
> The OSX manpage for fgetxattr() seem to mention the XATTR_NOFOLLOW flag
> for getxattr() only.
>
> https://www.unix.com/man-page/osx/2/fgetxattr/
>
> XATTR_NOFOLLOW  do not follow symbolic links.  getxattr() normally returns
>                 information from the target of path if it is a symbolic link.
>                 With this option, getxattr() will return extended attribute
>                 data from the symbolic link instead.

Ah sorry, you're correct of course. Will fix.

>> so I believe it needs to be factored out nevertheless. Are you just
>> proposing doing that later in the patch series?
>
> Maybe introduce a qemu_fgetxattr() API in 9p-utils.h ? In a separate patch, or
> maybe in patch 10.
>
> #ifdef CONFIG_DARWIN
> #define qemu_fgetxattr(...) fgetxattr(__VA_ARGS__, 0, 0)
> #else
> #define qemu_fgetxattr fgetxattr
> #endif
>

Sounds good. I'll do this in a separate patch, since the *at versions
are all similar while
this is a bit different.
