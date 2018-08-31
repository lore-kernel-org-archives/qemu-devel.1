Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvjau-0005lR-Ph
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvjQp-0004DS-KV
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:25:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1fvjQp-0004DK-CJ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:25:47 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-7-git-send-email-Liam.Merwick@oracle.com>
	<13bca354-a3d1-fa51-3581-322bd1351059@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <7854c6fc-9259-31b0-f5b8-dee31d68df78@oracle.com>
Date: Fri, 31 Aug 2018 14:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <13bca354-a3d1-fa51-3581-322bd1351059@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] block: dump_qlist() may dereference a
 Null pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



On 30/08/18 19:41, Eric Blake wrote:
> On 08/30/2018 10:47 AM, Liam Merwick wrote:
>> A NULL 'list' passed into function dump_qlist() isn't correctly
>> validated and can be passed to qlist_first() where it is dereferenced.
>=20
> But dump_qlist() is static, and it is easy to prove that it will never=20
> be called with a NULL 'list' parameter (it's lone caller did switch=20
> (qobject_type(obj)), and calls dump_qlist() only for QTYPE_QLIST, which=
=20
> implies that the qobject_to(QList, obj) will succeed and never be NULL).
>=20
>>
>> This could be resolved by checking if the list is NULL in dump_qlist()
>> and returning immediately. However, the general case can be handled by
>> adding a NULL arg check to to qlist_first() and qlist_next() and all
>> the callers to those functions handle that cleanly.
>=20
> NACK.=C2=A0 If anything, I'd be happier with:
>=20
> assert(list);
>=20

Thank works for me too.

Regards,
Liam

> in dump_qlist() to shut up the lint checker, as we do not want to slow=20
> down the common case of qlist_first() for something that does not=20
> happen.=C2=A0 That is, the null dereference in qlist_first() is a featu=
re for=20
> detecting buggy code, and not something we need to change.
>=20
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>>
>> ---
>> =C2=A0 include/qapi/qmp/qlist.h | 6 ++++++
>> =C2=A0 1 file changed, 6 insertions(+)
>>
>> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
>> index 8d2c32ca2863..1ec716e2eb9e 100644
>> --- a/include/qapi/qmp/qlist.h
>> +++ b/include/qapi/qmp/qlist.h
>> @@ -58,11 +58,17 @@ void qlist_destroy_obj(QObject *obj);
>> =C2=A0 static inline const QListEntry *qlist_first(const QList *qlist)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 if (!qlist) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return QTAILQ_FIRST(&qlist->head);
>> =C2=A0 }
>> =C2=A0 static inline const QListEntry *qlist_next(const QListEntry *en=
try)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 if (!entry) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return QTAILQ_NEXT(entry, next);
>> =C2=A0 }
>>
>=20
