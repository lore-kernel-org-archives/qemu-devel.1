Received: from eggs.gnu.org ([2001:4830:134:3::10]:44073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZlQq-0004Jp-4G
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZlQp-0000rk-99
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:02:28 -0400
References: <20170724153952.26510-1-eblake@redhat.com>
	<20170724153952.26510-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <78846349-b145-a3a4-4e0f-8861b7423205@redhat.com>
Date: Mon, 24 Jul 2017 18:02:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170724153952.26510-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] iotests: Check dirty
 bitmap statistics in 124
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/24/2017 11:39 AM, Eric Blake wrote:
> We had a bug for multiple releases where dirty-bitmap count was
> documented in bytes but reported in sectors; enhance the testsuite
> to add coverage of DirtyBitmapInfo to ensure we do not regress again.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/124 | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
> index d0d2c2bfb0..8e76e62f93 100644
> --- a/tests/qemu-iotests/124
> +++ b/tests/qemu-iotests/124
> @@ -336,7 +336,12 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
>                              (('0xab', 0, 512),
>                               ('0xfe', '16M', '256k'),
>                               ('0x64', '32736k', '64k')))
> -
> +        # Check the dirty bitmap stats
> +        result = self.vm.qmp('query-block')
> +        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/name', 'bitmap0')
> +        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/count', 458752)
> +        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/granularity', 65536)
> +        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/status', 'active')
> 
>           # Prepare a cluster_size=128k backup target without a backing file.
>           (target, _) = bitmap0.new_target()
> 

Good addition.

Reviewed-by: John Snow <jsnow@redhat.com>
