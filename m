Received: from eggs.gnu.org ([2001:4830:134:3::10]:37926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQWhg-0006Hl-D9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQWhd-0003gz-BI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:57:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQWhd-0003gF-5L
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:57:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
	<57991CC1.40003@redhat.com> <8737mudp81.fsf@oc4731375738.ibm.com>
	<87r3a34o8d.fsf@dusky.pond.sub.org>
Date: Mon, 09 Jan 2017 10:57:17 +0100
In-Reply-To: <87r3a34o8d.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 05 Aug 2016 10:24:50 +0200")
Message-ID: <87r34co8si.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sascha Silbe <silbe@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

Markus Armbruster <armbru@redhat.com> writes:

> Sascha Silbe <silbe@linux.vnet.ibm.com> writes:
>
>> Dear Eric,
>>
>> Eric Blake <eblake@redhat.com> writes:
>>
>>>> +++ b/include/qapi/error.h
>>>> @@ -170,6 +170,9 @@ void error_setg_internal(Error **errp,
>>>>   * Just like error_setg(), with @os_error info added to the message.
>>>>   * If @os_error is non-zero, ": " + strerror(os_error) is appended to
>>>>   * the human-readable error message.
>>>> + *
>>>> + * The value of errno (which usually can get clobbered by almost any
>>>> + * function call) will be preserved.
>>>>   */
>>>>  #define error_setg_errno(errp, os_error, fmt, ...)                      \
>>>>      error_setg_errno_internal((errp), __FILE__, __LINE__, __func__,     \
>>>
>>> Do we need/want to make the guarantee of preserving errno across any of
>>> the other functions and macros declared in error.h?
>>
>> It would be more consistent to have all error reporting functions
>> promise this, even if they do not get passed the errno. In some cases
>> the errno might not matter to the user (so error_setg_errno() isn't
>> used), but still be passed on to the caller to signal an error (so
>> clobbering it could be problematic).
>>
>> Can prepare a follow-up patch that makes sure error_setg(),
>> error_propagate(), error_setg_file_open(), error_set() preserve
>> errno. Optionally also the other functions listed in
>> include/qapi/error.h and include/qemu/error-report.h.
>
> Suggest:
>
> * A patch to document existing errno-preserving behavior.
>
> * Patches to reduce inconsistency, if any.  E.g. say all but one
>   error_setg() function preserve errno, make the exception preserve it,
>   too.
>
> * Optionally, patches to add more errno-preserving behavior you consider
>   useful.  I can't promise such patches will be applied, only that they
>   will be reviewed :)

Hmm, looks like I held onto your patch in the hope of getting a few
more, then forgot about it.  Since it still applies, I'll take it now.
Doesn't mean I've lost my hope for more of them :)
