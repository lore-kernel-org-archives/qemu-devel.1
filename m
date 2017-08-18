Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dipBk-0007SU-J2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dipBg-0002Ft-Lf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:52:20 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dipBg-0002Fc-Fs
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:52:16 -0400
Received: by mail-qk0-x244.google.com with SMTP id u139so2116195qka.3
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:52:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-3-eblake@redhat.com>
	<cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
	<d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e9bf40e3-a99c-7c46-f2a2-e2f2da2c4b0f@amsat.org>
Date: Fri, 18 Aug 2017 18:52:13 -0300
MIME-Version: 1.0
In-Reply-To: <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 08/18/2017 06:39 PM, Eric Blake wrote:
> On 08/18/2017 04:33 PM, Philippe Mathieu-Daudé wrote:
>> Hi Eric,
>>
>> On 08/18/2017 06:15 PM, Eric Blake wrote:
>>> Assertions should be separate from the side effects, since in
>>> theory, g_assert() can be disabled (in practice, we can't really
>>> ever do that).
>>
>> What about the suggestion on your "Hacks for building on gcc 7 / Fedora
>> 26" series about avoid building without assertions?
> 
> NDEBUG doesn't affect g_assert() (only assert(), but that wasn't in use
> here) - I have to double-check glib documentation to see whether
> g_assert() can be crippled in a manner similar to how I know assert()
> can be crippled.  Ideally, we have a form that always performs side
> effects exactly once, whether or not abort-on-error is enabled (assert()
> does not have that, but I don't know whether glib does).

Yes it does:

https://developer.gnome.org/glib/stable/glib-Testing.html#g-assert

"The macro can be turned off in final releases of code by defining 
G_DISABLE_ASSERT when compiling the application, so code must not depend 
on any side effects from expr ."

> 
>>
>> The obvious win is a more readable code.
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html
> 
> Indeed, that's a patch proposal that I still haven't written, but it can
> be done independently of this series.
> 
> Still, even if we guarantee that assertions will never be crippled for
> qemu, it is bad practice to code side-effects in an assert(), because it
> makes the code harder to copy-and-paste into projects that DO work with
> assertions disabled, and it raises red flags in reviewers' minds of
> whether it was intentional.

This is a good point.

> [And truth be told, this particular patch is not really about libqtest,
> so much as something that horrified me when I was grepping for
> qemu_strtoul() in order to fix the checkpatch warning I got on
> libqtest's raw use of strtol() in patch 6, and which necessitated me to
> write patch 5 - even though the name of the file in question is 'qtest.c']
> 
