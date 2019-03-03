Received: from eggs.gnu.org ([209.51.188.92]:35646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0GQI-0004Ln-73
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 21:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0GQH-0001km-Cy
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 21:00:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0GQH-0001jq-4I
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 21:00:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so1488502wmg.2
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 18:00:12 -0800 (PST)
References: <20190302223825.11192-1-philmd@redhat.com>
	<20190302223825.11192-3-philmd@redhat.com>
	<26f2a83e-588a-c26c-86dc-51d5b8170ae9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a96c8ce-1e3c-f88d-322a-b12645796a3d@redhat.com>
Date: Sun, 3 Mar 2019 03:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <26f2a83e-588a-c26c-86dc-51d5b8170ae9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] util/error: Remove unnecessary
 saved_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 3/3/19 2:12 AM, Eric Blake wrote:
> On 3/2/19 4:38 PM, Philippe Mathieu-Daudé wrote:
>> Since 552375088a8, error_set_errno() calls error_setv() which
>> already protect errno for clobbering.
>> Remove the now unnecessary saved_errno.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  util/error.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/util/error.c b/util/error.c
>> index 934a78e1b1..0402fa1b9d 100644
>> --- a/util/error.c
>> +++ b/util/error.c
>> @@ -101,14 +101,11 @@ void error_setg_errno_internal(Error **errp,
>>                                 int os_errno, const char *fmt, ...)
>>  {
>>      va_list ap;
>> -    int saved_errno = errno;
>>  
>>      va_start(ap, fmt);
>>      error_setv(errp, src, line, func, ERROR_CLASS_GENERIC_ERROR, fmt, ap,
>>                 os_errno != 0 ? strerror(os_errno) : NULL);
>>      va_end(ap);
>> -
>> -    errno = saved_errno;
> 
> NACK. strerror() can clobber errno, so you still need to restore
> saved_errno, regardless of what error_setv() does internally.

Oops, I thought only strerror_r() would change errno, but checking the
man page I now see you are right:

  POSIX.1-2001 and POSIX.1-2008 require that a successful call to
  strerror() or strerror_l() shall leave errno unchanged, and note
  that, since no function return value is reserved to indicate an
  error, an application that wishes to check for errors should
  initialize errno to zero before the call, and then check errno
  after the call.

Thanks for catching that!

Phil.
