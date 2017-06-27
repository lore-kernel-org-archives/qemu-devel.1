Received: from eggs.gnu.org ([2001:4830:134:3::10]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPvYv-0001Gi-4D
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPvYu-0000y1-6y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:50:09 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dPvYt-0000wm-UR
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:50:08 -0400
Received: by mail-wm0-x229.google.com with SMTP id w126so32853114wme.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 11:50:07 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87efutd9lj.fsf@dusky.pond.sub.org>
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
	<CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
	<e340cdb9-3c97-8624-81d9-f7888f819a68@amsat.org>
	<CAKmqyKOOhu7iKuW4naNi0+7cwayLaftkPf=gS7uBakMvKavxVQ@mail.gmail.com>
	<270686d0-1ca8-965f-a14a-397f45616deb@redhat.com>
	<87shjc2rkb.fsf@dusky.pond.sub.org>
	<CAKmqyKMJ8ZgTPtEj73pBDU+mf578tubKPUPsP4mTD8veX90K-w@mail.gmail.com>
	<878tl3kodm.fsf@dusky.pond.sub.org>
	<CAKmqyKP3S7mBwQzC0yV4MpQddcKvGXtXrPyY68X7t62YwLqy3g@mail.gmail.com>
	<871squz7l8.fsf@dusky.pond.sub.org>
	<CAKmqyKMQyYObpsFd6hGe3zjPSJRKyWZqMGfuFSMJULzmvoD_eA@mail.gmail.com>
	<87efutd9lj.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 11:49:35 -0700
Message-ID: <CAKmqyKPF6ynpByifMApNrUh+LsMBpSh-WNWSGBFv9VgNvXytZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] char-socket: Don't report TCP
 socket waiting as an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Thu, Jun 8, 2017 at 10:16 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> On Thu, Jun 8, 2017 at 10:56 AM, Markus Armbruster <armbru@redhat.com> wrote:
>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>
>>>> On Wed, Jun 7, 2017 at 11:03 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>>>
>>>>>> On Wed, Jun 7, 2017 at 12:19 AM, Markus Armbruster <armbru@redhat.com> wrote:
>>>>>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>>>>>
>>>>>>>> On 06/06/2017 18:30, Alistair Francis wrote:
>>>>>>>>>>
>>>>>>>>>> This is somehow confusing. I don't think it is worth having another
>>>>>>>>>> qemu_log_stderr() function rather than using error_report() but this very
>>>>>>>>>> call might deserve a comment explaining this unusual use. What do you think?
>>>>>>>>>
>>>>>>>>> The problem with stderr is that this isn't an error. Some uses of QEMU
>>>>>>>>> (inside Eclipse for example) flag everything printed on stderr as red
>>>>>>>>> which confuses users that they are seeing an error when they really
>>>>>>>>> aren't.
>>>>>>>>
>>>>>>>> But they are wrong.
>>>>>>>
>>>>>>> Concur.  We also print warnings and informational messages to stderr.
>>>>>>>
>>>>>>> We should make errors easy to recognize.  Fortunately, error_report()
>>>>>>> prints errors to stderr in a rigid format.  Unfortunately, error
>>>>>>> messages bypassing error_report() still exist in places.  We suck.
>>>>>>>
>>>>>>> The format is
>>>>>>>
>>>>>>>     timestamp-if-enabled progname ':' location message
>>>>>>>
>>>>>>> timestamp-if-enabled is normally empty.  With -msg timestamp=on, it's
>>>>>>> the current time in ISO 8601 format, followed by a space.
>>>>>>>
>>>>>>> progname is the program name (main()'s argv[0]).
>>>>>>>
>>>>>>> location is either empty, or a reference to the command line or a
>>>>>>> configuration file.
>>>>>>>
>>>>>>> See error_vreport() for details.
>>>>>>
>>>>>> Ok, but this isn't an error, it's more information. So it sounds like
>>>>>> we should still print to stderr but not print in the format described
>>>>>> above?
>>>>>
>>>>> Yes.
>>>>>
>>>>> I explained the error message format to show how to distinguish actual
>>>>> errors from other stuff.
>>>>
>>>> Sorry, I should have been more clear. I meant we should not use the
>>>> error_report() function here. I don't think we have any
>>>> warning_report() function though, is that something worth having?
>>>
>>> So far we simply use error_printf() for such things.
>>>
>>> A function to report a warning would let us report them more uniformly,
>>> but only if we actually use it uniformly.  In other words, adding one
>>> without also converting the existing warnings to use it would create yet
>>> another open-ended incremental conversion job.  Are we up to it?
>>
>> Yeah! Why not. I am happy to give it a shot changing some errors to warnings.
>>
>> First thing though, what is the format for printing warnings?
>
> We make one up.
>
> For what it's worth, gcc uses the same format as for errors with the
> message prefixed either by "warning: " or by "error: ".  Also common is
> prefixing warnings, but not errors.

Ok, I think that is what I'm going to do. I will send a patch series
out soon that basically copies the error_report() format but prefixes
it with warning.

I also removed the timestamp for the warning, although I'm not sure if
that is what we want to do. I'll CC you when I send it out.

Thanks,
Alistair

>
> We already have several error_report() calls with messages that start
> with (a variation of) "warning: ".
>
