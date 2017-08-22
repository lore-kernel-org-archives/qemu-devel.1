Received: from eggs.gnu.org ([2001:4830:134:3::10]:39642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkBVd-0005Tv-7y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkBVc-00022L-FI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:54:29 -0400
MIME-Version: 1.0
In-Reply-To: <87ziarep0c.fsf@dusky.pond.sub.org>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-5-git-send-email-armbru@redhat.com>
	<CAJ+F1CLhMBQuKFT1w9Q-U1xAts4zpERNd_CZB7V2Yg4w0Q+m3g@mail.gmail.com>
	<87ziarep0c.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 17:54:21 +0200
Message-ID: <CAJ+F1CK2Rx=vS3yNH_6bnYEZXwFycgmTT4a407fu0xMR6_DFPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/56] char: Make ringbuf-read size
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, jcody <jcody@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Hi

On Tue, Aug 22, 2017 at 3:00 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> Hi
>>
>> On Mon, Aug 7, 2017 at 4:45 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> Sizes should use QAPI type 'size' (uint64_t).  ringbuf-read parameter
>>> @size is 'int' (int64_t).  qmp_ringbuf_read() rejects negative values,
>>> then implicitly converts to size_t.
>>>
>>> Change the parameter to 'size' and drop the check for negative values.
>>>
>>> ringbuf-read now accepts size values between 2^63 and 2^64-1.  It
>>> accepts negative values as before, because that's how the QObject
>>> input visitor works for backward compatibility.
>>>
>>
>> Negative values over json will be implicitly converted to positive
>> values with this change, right? Or are they rejected earlier?
>
> Yes.  For details, see my reply to Juan's review of PATCH 15.
>
>> If so that is a change of behaviour that I am not sure is worth doing
>> now (without explicit protocol break), but I don't mind.

So before this change:

(QEMU) ringbuf-read device=3Dfoo size=3D-1
{"error": {"class": "GenericError", "desc": "size must be greater than zero=
"}}

after:

(QEMU) ringbuf-read device=3Dfoo size=3D-1
{"return": ""}

Is this really what we want?

--=20
Marc-Andr=C3=A9 Lureau
