Received: from eggs.gnu.org ([2001:4830:134:3::10]:45474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gV0Uk-00034v-H8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gV0Uj-0008MO-QI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:43:38 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
	<20181206192544.3987-2-jsnow@redhat.com>
	<1bba0107-89d3-eb83-b242-9faebaac3ec4@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0db3e096-666c-8740-da84-cc6c1180cecf@redhat.com>
Date: Thu, 6 Dec 2018 15:43:30 -0500
MIME-Version: 1.0
In-Reply-To: <1bba0107-89d3-eb83-b242-9faebaac3ec4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] blockdev: abort transactions in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>



On 12/6/18 3:37 PM, Eric Blake wrote:
> On 12/6/18 1:25 PM, John Snow wrote:
>> Presently, we abort transactions in the same order they were processed
>> in.
>> Bitmap commands, though, attempt to restore backup data structures on
>> abort.
>> To that end, though, they need to be aborted in reverse chronological
>> order.
>>
>> Replace the QSIMPLEQ data structure with a QTAILQ one, so we can itera=
te
>> in reverse for the abort phase of the transaction.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c | 14 +++++++-------
>> =C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> Does this need to cc qemu-stable? I'm trying to figure out if it affect=
s
> any of the transactions issued by my libvirt code demo'd at KVM Forum.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Hmm, possibly. merge is of course an x-prefix, but "clear" uses the same
restoration technique. I suppose if you cleared the same bitmap multiple
times and tried to roll it back you could see trouble where we restore
an already cleared bitmap.

I'll say that patch 01/03 here should be considered a bugfix, yes, but I
wanted to see if anyone thought this had consequences I hadn't
considered yet.

--js
