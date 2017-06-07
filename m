Received: from eggs.gnu.org ([2001:4830:134:3::10]:50884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIVFU-0006j9-R8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIVFR-0003K9-Mt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIVFR-0003Ji-H2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:19:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
	<CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
	<e340cdb9-3c97-8624-81d9-f7888f819a68@amsat.org>
	<CAKmqyKOOhu7iKuW4naNi0+7cwayLaftkPf=gS7uBakMvKavxVQ@mail.gmail.com>
	<270686d0-1ca8-965f-a14a-397f45616deb@redhat.com>
Date: Wed, 07 Jun 2017 09:19:16 +0200
In-Reply-To: <270686d0-1ca8-965f-a14a-397f45616deb@redhat.com> (Paolo
	Bonzini's message of "Wed, 7 Jun 2017 00:14:37 +0200")
Message-ID: <87shjc2rkb.fsf@dusky.pond.sub.org>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/06/2017 18:30, Alistair Francis wrote:
>>>
>>> This is somehow confusing. I don't think it is worth having another
>>> qemu_log_stderr() function rather than using error_report() but this very
>>> call might deserve a comment explaining this unusual use. What do you think?
>> 
>> The problem with stderr is that this isn't an error. Some uses of QEMU
>> (inside Eclipse for example) flag everything printed on stderr as red
>> which confuses users that they are seeing an error when they really
>> aren't.
>
> But they are wrong.

Concur.  We also print warnings and informational messages to stderr.

We should make errors easy to recognize.  Fortunately, error_report()
prints errors to stderr in a rigid format.  Unfortunately, error
messages bypassing error_report() still exist in places.  We suck.

The format is

    timestamp-if-enabled progname ':' location message

timestamp-if-enabled is normally empty.  With -msg timestamp=on, it's
the current time in ISO 8601 format, followed by a space.

progname is the program name (main()'s argv[0]).

location is either empty, or a reference to the command line or a
configuration file.

See error_vreport() for details.

[...]
