Received: from eggs.gnu.org ([2001:4830:134:3::10]:44615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa3KI-00074c-FL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa3KH-0003Po-Ch
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:13:26 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-2-jsnow@redhat.com>
	<3a32f921-7800-a4f3-12ac-195212cbe828@redhat.com>
	<05a181af-5038-826f-2873-dec4a04f22e9@redhat.com>
	<20180702075939.GE24405@paraplu>
From: John Snow <jsnow@redhat.com>
Message-ID: <6810783c-a3ad-57ab-cf2e-96e6643c9306@redhat.com>
Date: Mon, 2 Jul 2018 14:13:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180702075939.GE24405@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: allow blockdev-backup from
 any source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 07/02/2018 03:59 AM, Kashyap Chamarthy wrote:
> On Thu, Jun 28, 2018 at 05:19:37PM -0400, John Snow wrote:
>>
>>
>> On 06/28/2018 02:05 PM, Eric Blake wrote:
>>> On 06/28/2018 01:00 PM, John Snow wrote:
>>>> In the case of image fleecing, the node we choose as the source
>>>> for a blockdev-backup is going to be both a root node AND the
>>>> backing node for the exported image. It does not qualify as a root
>>>> image in this case.
>>>>
>>>> Loosen the restriction.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>> =C2=A0 blockdev.c | 2 +-
>>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> In v1, you mentioned that this used to work but then regressed,
>>> pinpointing that detail in the commit message might be nice, but not
>>> essential (since we didn't test it until now).=C2=A0 So,
>>>
>>
>> Really not sure when it regressed; I consider it unimportant as nothin=
g
>> uses it presently: no docs, no tests, nothing in libvirt.
>>
>> My guess, though, is that it worked prior to
>> cef34eebf3d0f252a3b3e9a2a459b6c3ecc56f68.
>=20
> So the above commit adds the ability to assign node names for
> `blockdev-backup`, which wasn't possible during 2.8 timeframe.
>=20
>> In 2.8, possibly?
>>
>> Kashyap might know, I think he's experimented with this sometime in th=
at
>> timezone.
>=20
> I don't recall doing the "allow blockdev-backup from any source" test
> with 2.8.  (But I recall gradually moving from figuring out the source
> block device via wading through the output of `query-named-block-nodes`
> to using the 'node-name'.)
>=20
> Looking at my test notes with QEMU 2.8, this was my
> workflow (see how `blockdev-backup` still doesn't use 'node-name's):
>=20
> (QEMU) blockdev-add driver=3Dqcow2 node-name=3Dnode2 file=3D{"driver":"=
file","filename":"/export/target.qcow2"} backing=3D{"driver":"qcow2","fil=
e":{"driver":"file","filename":"/export/base.qcow2"}}
> (QEMU) query-named-block-nodes # To dig through the source block device=
 "#blockYYY"
> (QEMU) blockdev-backup device=3D#block197 target=3Dnode1 sync=3Dnone
> (QEMU) nbd-server-start addr=3D{"type":"unix","data":{"path":"./nbd-soc=
k"}}
> (QEMU) nbd-server-add device=3Dnode1
> (QEMU) nbd-server-stop
>=20
> Later on I moved (thanks to the Git commit you mentioned earlier) to th=
e
> much cleaner approach of using 'node-name' (the below syntax is
> from my test notes with QEMU 2.12):
>=20
> (QEMU) blockdev-add driver=3Dqcow2 node-name=3Dnode-E file=3D{"driver":=
"file","filename":"e.qcow2"}
> (QEMU) blockdev-backup device=3Dnode-B target=3Dnode-E sync=3Dfull job-=
id=3Djob0
> [...]
>=20

Without this patch, "allow blockdev-backup from any source", the
fleecing workflow prohibits the blockdev-backup command. We're wondering
when that regressed.

If you managed to get fleecing working without this patch here, then it
was working at that time.

--js
