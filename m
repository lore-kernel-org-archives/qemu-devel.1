Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYV5f-0006nN-B0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYV5e-0000CL-Fu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:23:23 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYV5e-00008t-8R
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:23:22 -0400
Received: by mail-wr0-x231.google.com with SMTP id k71so27142862wrc.2
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 03:23:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
	<eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 11:22:59 +0100
Message-ID: <CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c: Avoid warning
 on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, "patches@linaro.org" <patches@linaro.org>

On 20 July 2017 at 19:26, Eric Blake <eblake@redhat.com> wrote:
> On 07/20/2017 11:32 AM, Peter Maydell wrote:
>> On NetBSD the compiler warns:
>> util/oslib-posix.c: In function 'sigaction_invoke':
>> util/oslib-posix.c:589:5: warning: missing braces around initializer [-Wmissing-braces]
>>      siginfo_t si = { 0 };
>>      ^
>
> Uggh. That is a broken compiler.  C99 declares that 'anything = {0}' is
> supposed to be a valid way to zero-initialize anything.
>
>> util/oslib-posix.c:589:5: warning: (near initialization for 'si.si_pad') [-Wmissing-braces]
>>
>> because on this platform siginfo_t is defined as
>>   typedef union siginfo {
>>           char    si_pad[128];    /* Total size; for future expansion */
>>           struct _ksiginfo _info;
>>   } siginfo_t;
>>
>> Avoid this warning by initializing the struct with {} instead;
>> this is a GCC extension but we use it all over the codebase already.
>
> Well, I'm glad that works to shut up the broken compiler.
>
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  util/oslib-posix.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; applied to master.

-- PMM
