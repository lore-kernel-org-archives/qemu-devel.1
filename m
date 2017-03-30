Received: from eggs.gnu.org ([2001:4830:134:3::10]:40382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctX9R-00016l-2E
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctX9Q-0001dx-7I
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:17:57 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctX9Q-0001dn-0p
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:17:56 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l43so54621314wre.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 03:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490707129-12622-1-git-send-email-peter.maydell@linaro.org>
References: <1490707129-12622-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 11:17:34 +0100
Message-ID: <CAFEAcA_kBUEXiKaiT=Y=83nSsoxW=Hjn_=DEFYs1s4OK5ctG-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] configure: Don't claim
 'unsupported host OS' when better message available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, "patches@linaro.org" <patches@linaro.org>

On 28 March 2017 at 14:18, Peter Maydell <peter.maydell@linaro.org> wrote:
> The change in commit 898be3e0415c6d which made completely
> unrecognized OSes cause an error_exit "Unsupported host OS"
> has some unfortunate unintended effects:
>  * if you run 'configure --help' on an unsupported host OS
>    (eg if intending to use it as a build machine for a
>    cross compile to a supported host) then the message
>    is printed instead of --help
>  * if the C compiler doesn't work or is missing (eg if
>    you passed an incorrect --cross-prefix by mistake)
>    the message is printed instead of the more useful
>    'compiler does not exist or does not work' message
>
> Fix this by postponing the error_exit in this situation
> until later, when we have already identified the more
> useful cases for this.

> +if test "$bogus_os" = "yes"; then
> +    # Now that we know that we're not printing the help and that
> +    # the compiler works (so the results of the check_defines we used
> +    # to identify the OS are reliable), if we didn't recognize the
> +    # host OS we should stop now.
> +    error_exit "Unsupported host OS $targetos"
> +fi

Oops, I just noticed I had a minor change here which I forgot
to squash in before sending:

-    error_exit "Unsupported host OS $targetos"
+    error_exit "Unrecognized host OS $targetos"

since this is the case of "we don't know what this is" rather
than "we know what this is but we're planning to remove it".

OK to squash that in when I apply this patch?

thanks
-- PMM
