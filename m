Received: from eggs.gnu.org ([2001:4830:134:3::10]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f8jcP-0003TS-9C
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f8jcO-0001Ol-EO
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:43:13 -0400
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-4-nirsof@gmail.com>
	<d66868b2-591b-28ce-d7dd-e8af3f8fc6cd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0056ea25-e71f-2ae8-ae4e-e678ab7280ab@virtuozzo.com>
Date: Wed, 18 Apr 2018 12:43:00 +0300
MIME-Version: 1.0
In-Reply-To: <d66868b2-591b-28ce-d7dd-e8af3f8fc6cd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test new qemu-nbd
 --nolist option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

17.04.2018 22:56, Eric Blake wrote:
> On 04/13/2018 02:26 PM, Nir Soffer wrote:
>> Add new test module for tesing the --nolist option.
>>
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>> +iotests.log('Check that listing exports is allowed by default')
>> +disk, nbd_sock = iotests.file_path('disk1', 'nbd-sock1')
>> +iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1m')
>> +iotests.qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, '-x', 'export', disk)
>> +out = iotests.run('nbd-client', '-l', '--unix', nbd_sock)
> Should we really be relying on the third-party nbd-client to be
> installed?  Would it not be better to teach our own NBD client to learn
> how to do interesting things over NBD?  Your use case of listing the
> output of NBD_OPT_LIST is one, but another that readily comes to mind is
> listing the possibilities of NBD_OPT_LIST_META_CONTEXT that just went
> into 2.12.  Maybe making 'qemu-img info' give more details when
> connecting to an NBD server, compared to what is normally needed just
> for connecting to an export on that server?
>
> Additionally, once we merge in Vladimir's work to expose persistent
> dirty bitmaps via NBD_OPT_SET_META_CONTEXT/NBD_CMD_BLOCK_STATUS, it
> would be nice to have an in-tree tool for reading out the context
> information of an NBD export, perhaps extending what 'qemu-img map' can
> already do (Vladimir already mentioned that he only implemented the
> server side, and left the client side for an out-of-tree solution [1],
> although I'm wondering if that is still the wisest course of action).
>
> [1]

Client part for base:allocation is done, and qemu-img map shows it, 
client part for dirty bitmaps export - isn't.


>
>> +
>> +assert 'export' in out.splitlines(), 'Export not in %r' % out
>> +
>> +iotests.log('Check that listing exports is forbidden with --nolist')
>> +disk, nbd_sock = iotests.file_path('disk2', 'nbd-sock2')
>> +iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1m')
>> +iotests.qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, '-x', 'secret',
>> +                 '--nolist', disk)
>> +
>> +# nbd-client fails when listing is not allowed, but lets not depend on 3rd
> s/lets/let's/
>


-- 
Best regards,
Vladimir
