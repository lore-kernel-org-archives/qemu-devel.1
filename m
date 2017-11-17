Received: from eggs.gnu.org ([2001:4830:134:3::10]:57857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eFjMI-0000fG-DN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eFjMF-00080i-6j
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:19:14 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <e30a779a-df6d-b929-f39b-ee4b3a580443@redhat.com>
References: <20171106145345.12038-1-berto@igalia.com>
	<e30a779a-df6d-b929-f39b-ee4b3a580443@redhat.com>
Date: Fri, 17 Nov 2017 17:19:09 +0100
Message-ID: <w51po8glvya.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Close a BlockDriverState completely
 even when bs->drv is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri 17 Nov 2017 05:14:08 PM CET, Max Reitz wrote:
> On 2017-11-06 15:53, Alberto Garcia wrote:
>> bdrv_close() skips much of its logic when bs->drv is NULL. This is
>> fine when we're closing a BlockDriverState that has just been created
>> (because e.g the initialization process failed), but it's not enough
>> in other cases.
>> 
>> For example, when a valid qcow2 image is found to be corrupted then
>> QEMU marks it as such in the file header and then sets bs->drv to
>> NULL in order to make the BlockDriverState unusable. When that BDS is
>> later closed then many of its data structures are not freed (leaking
>> their memory) and none of its children are detached. This results in
>> bdrv_close_all() failing to close all BDSs and making this assertion
>> fail when QEMU is being shut down:
>> 
>>    bdrv_close_all: Assertion `QTAILQ_EMPTY(&all_bdrv_states)' failed.
>> 
>> This patch makes bdrv_close() do the full uninitialization process
>> in all cases. This fixes the problem with corrupted images and still
>> works fine with freshly created BDSs.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block.c                    | 57 +++++++++++++++++++++++-----------------------
>>  tests/qemu-iotests/060     | 13 +++++++++++
>>  tests/qemu-iotests/060.out | 12 ++++++++++
>>  3 files changed, 53 insertions(+), 29 deletions(-)
>
> Sooo...  What's the exact status of this patch? :-)

I can resend it rebased on top of your block branch, but I'm fine if you
merge the iotest manually (it's a trivial merge).

I'm not sure about Kevin's comments though, it wasn't clear to me if
he's fine if we apply this patch or not.

Berto
