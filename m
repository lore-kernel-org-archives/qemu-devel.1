Received: from eggs.gnu.org ([2001:4830:134:3::10]:38474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ePsca-0007uO-35
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ePscW-0000xl-SV
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:14:00 -0500
Received: from mail-he1eur01on0097.outbound.protection.outlook.com
	([104.47.0.97]:45366
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ePscW-0000td-3D
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:13:56 -0500
References: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
	<76f5ec24-112f-455a-4ad4-5c97d7182f36@redhat.com>
	<20171130143306.GC4039@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <328818d5-8d63-8aec-aba2-40404e03503c@virtuozzo.com>
Date: Fri, 15 Dec 2017 19:13:37 +0300
MIME-Version: 1.0
In-Reply-To: <20171130143306.GC4039@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] export root node for write through NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

30.11.2017 17:33, Kevin Wolf wrote:
> Am 30.11.2017 um 15:21 hat Max Reitz geschrieben:
>> On 2017-11-30 08:47, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all.
>>>
>>> We need the following option: start vm in stopped mode (-S) and write
>>> it's disk before start through NBD.
>>> It should be absolutely safe, but unfortunately it is disallowed by roo=
t
>>> role of the disk.
>>> Is there any workaround or if not, what is a true way to implement this
>>> possibility?
>>>
>>> ----
>>> error message:
>>>  =A0=A0=A0 unable to execute QEMU command 'nbd-server-add': Conflicts w=
ith use
>>> by drive0 as 'root', which does not allow 'write' on #block100
>> One thing that comes to mind is adding the guest device only after you
>> are done with NBD.
>>
>> The other of course is to set share-rw=3Don for the device.
> We already allow this with incoming migration, in that case the
> BlockBackend for the guest device stays inactive and doesn't request
> permissions yet.
>
> I've been thinking for a while that it would be nice to unify the
> startup of "normal" VMs and incoming migration, so that images are
> always opened inactive first and then get activated.
>
> The interesting point for you could be that opening the image happens
> immediately when the process starts, but activation would only happen
> when the VM actually starts running (i.e. on 'cont').
>
> Kevin

Could it be as simple as:

diff --git a/block/block-backend.c b/block/block-backend.c
index 3064cb888f..b8cbb43f02 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -709,7 +709,9 @@ static int blk_do_attach_dev(BlockBackend *blk, void=20
*dev)
 =A0=A0=A0=A0 /* While migration is still incoming, we don't need to apply =
the
 =A0=A0=A0=A0=A0 * permissions of guest device BlockBackends. We might stil=
l have=20
a block
 =A0=A0=A0=A0=A0 * job or NBD server writing to the image for storage migra=
tion. */
-=A0=A0=A0 if (runstate_check(RUN_STATE_INMIGRATE)) {
+=A0=A0=A0 if (runstate_check(RUN_STATE_INMIGRATE) ||
+=A0=A0=A0=A0=A0=A0=A0 runstate_check(RUN_STATE_PRELAUNCH))
+=A0=A0=A0 {
 =A0=A0=A0=A0=A0=A0=A0=A0 blk->disable_perm =3D true;
 =A0=A0=A0=A0 }


(at least it fixes my case)

--=20
Best regards,
Vladimir
