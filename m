Received: from eggs.gnu.org ([2001:4830:134:3::10]:45770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIqXG-0007tS-Iw
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIqXD-0002Tq-9p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIqXD-0002SD-0U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:03:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
	<CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
	<e340cdb9-3c97-8624-81d9-f7888f819a68@amsat.org>
	<CAKmqyKOOhu7iKuW4naNi0+7cwayLaftkPf=gS7uBakMvKavxVQ@mail.gmail.com>
	<270686d0-1ca8-965f-a14a-397f45616deb@redhat.com>
	<87shjc2rkb.fsf@dusky.pond.sub.org>
	<CAKmqyKMJ8ZgTPtEj73pBDU+mf578tubKPUPsP4mTD8veX90K-w@mail.gmail.com>
Date: Thu, 08 Jun 2017 08:03:01 +0200
In-Reply-To: <CAKmqyKMJ8ZgTPtEj73pBDU+mf578tubKPUPsP4mTD8veX90K-w@mail.gmail.com>
	(Alistair Francis's message of "Wed, 7 Jun 2017 16:47:43 -0700")
Message-ID: <878tl3kodm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Alistair Francis <alistair.francis@xilinx.com> writes:

> On Wed, Jun 7, 2017 at 12:19 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 06/06/2017 18:30, Alistair Francis wrote:
>>>>>
>>>>> This is somehow confusing. I don't think it is worth having another
>>>>> qemu_log_stderr() function rather than using error_report() but this very
>>>>> call might deserve a comment explaining this unusual use. What do you think?
>>>>
>>>> The problem with stderr is that this isn't an error. Some uses of QEMU
>>>> (inside Eclipse for example) flag everything printed on stderr as red
>>>> which confuses users that they are seeing an error when they really
>>>> aren't.
>>>
>>> But they are wrong.
>>
>> Concur.  We also print warnings and informational messages to stderr.
>>
>> We should make errors easy to recognize.  Fortunately, error_report()
>> prints errors to stderr in a rigid format.  Unfortunately, error
>> messages bypassing error_report() still exist in places.  We suck.
>>
>> The format is
>>
>>     timestamp-if-enabled progname ':' location message
>>
>> timestamp-if-enabled is normally empty.  With -msg timestamp=on, it's
>> the current time in ISO 8601 format, followed by a space.
>>
>> progname is the program name (main()'s argv[0]).
>>
>> location is either empty, or a reference to the command line or a
>> configuration file.
>>
>> See error_vreport() for details.
>
> Ok, but this isn't an error, it's more information. So it sounds like
> we should still print to stderr but not print in the format described
> above?

Yes.

I explained the error message format to show how to distinguish actual
errors from other stuff.
