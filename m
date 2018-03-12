Received: from eggs.gnu.org ([2001:4830:134:3::10]:48255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evJPu-0002Fo-5D
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evJPt-0002aM-7k
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:06:50 -0400
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
	<b570a199-9139-5652-5ad8-407820680620@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2cd2fd4e-ea14-90c5-ed63-d2569295d4e0@virtuozzo.com>
Date: Mon, 12 Mar 2018 12:06:34 +0300
MIME-Version: 1.0
In-Reply-To: <b570a199-9139-5652-5ad8-407820680620@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 6/9] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 23:40, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal realization: only one extent in server answer is supported.
>> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.
>>
>> Tests 140, 147 and 205 are fixed due to now server failed on searching
>> export in context of NBD_OPT_SET_META_CONTEXT option negotiation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>

[...]

>> +
>> =C2=A0 static int nbd_co_request(BlockDriverState *bs, NBDRequest *reque=
st,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 QEMUIOVector *write_qiov)
>> =C2=A0 {
>> @@ -784,6 +878,50 @@ int nbd_client_co_pdiscard(BlockDriverState *bs,=20
>> int64_t offset, int bytes)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_request(bs, &request, NULL)=
;
>> =C2=A0 }
>> =C2=A0 +int64_t coroutine_fn=20
>> nbd_client_co_get_block_status(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 int64_t sector_num,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 int nb_sectors,=20
>> int *pnum,
>> + BlockDriverState **file)
>
> Needs rebasing on top of Kevin's block branch to use the byte-based=20
> interface.=C2=A0 I also need to finish up my promised followups on that=20
> series, as NBD (and other protocol drivers) should have consistent=20
> behavior on what it means to report OFFSET_VALID (or whether that=20
> should be limited to just format/filter drivers).

Looks like it's already in master, so I should just rebase on master.--

Best regards,
Vladimir
