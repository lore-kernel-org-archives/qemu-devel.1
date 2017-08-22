Received: from eggs.gnu.org ([2001:4830:134:3::10]:45777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dk8ne-00012Y-0s
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dk8nZ-0002Cw-1w
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:00:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-5-git-send-email-armbru@redhat.com>
	<CAJ+F1CLhMBQuKFT1w9Q-U1xAts4zpERNd_CZB7V2Yg4w0Q+m3g@mail.gmail.com>
Date: Tue, 22 Aug 2017 15:00:19 +0200
In-Reply-To: <CAJ+F1CLhMBQuKFT1w9Q-U1xAts4zpERNd_CZB7V2Yg4w0Q+m3g@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	13:32:42 +0200")
Message-ID: <87ziarep0c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, jcody <jcody@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Aug 7, 2017 at 4:45 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Sizes should use QAPI type 'size' (uint64_t).  ringbuf-read parameter
>> @size is 'int' (int64_t).  qmp_ringbuf_read() rejects negative values,
>> then implicitly converts to size_t.
>>
>> Change the parameter to 'size' and drop the check for negative values.
>>
>> ringbuf-read now accepts size values between 2^63 and 2^64-1.  It
>> accepts negative values as before, because that's how the QObject
>> input visitor works for backward compatibility.
>>
>
> Negative values over json will be implicitly converted to positive
> values with this change, right? Or are they rejected earlier?

Yes.  For details, see my reply to Juan's review of PATCH 15.

> If so that is a change of behaviour that I am not sure is worth doing
> now (without explicit protocol break), but I don't mind.
