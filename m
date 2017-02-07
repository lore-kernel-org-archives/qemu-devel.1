Received: from eggs.gnu.org ([2001:4830:134:3::10]:32888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb4VZ-0003Tw-0z
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb4VY-0007eO-72
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:04:29 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb4VY-0007dJ-16
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:04:28 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v186so8141356wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 04:04:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206112953.16993-1-berrange@redhat.com>
References: <20170206112953.16993-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 12:04:06 +0000
Message-ID: <CAFEAcA8O64C3zuDq8QfFPLJekfvwsZ+E2FS+ETnHz75G8H5f+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] rules: don't try to create missing include
 dirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 6 February 2017 at 11:29, Daniel P. Berrange <berrange@redhat.com> wrote:
> In
>
>   commit ba78db44f6532d66a1e704bd44613e841baa2fc5
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Wed Jan 25 16:14:10 2017 +0000
>
>   make: move top level dir to end of include search path
>
> The dir $(BUILD_DIR)/$(@D) was added to the include
> path. This would sometimes point to a non-existant
> directory, if the sub-dir in question did not contain
> any target-independant files (eg tcg/). To deal with
> this the rules.mak attempted to create the directory.
>
> While this was succesful, it also caused accidental
> creation of files in the parent of the build dir.
> e.g. when building common source files into target
> specific output files.
>
> Rather than trying to workaround this, just revert
> the code that attempted to mkdir the missing include
> directories. Instead just turn off the compiler warning
> in question as the missing dir is expected & harmless
> in general.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

Thanks; planning to apply this to master as a buildfix with the
following added to the commit message:

    NB: you can clean up a build directory parent that has
    been filled with empty directories by commit ba78db44f653
    using this GNU find command in that parent directory:
      find audio backends block chardev crypto disas fsdev hw io linux-user \
        migration nbd net qapi qom replay slirp target ui util \
        -type d -empty -delete

thanks
-- PMM
