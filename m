Received: from eggs.gnu.org ([2001:4830:134:3::10]:58472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dAFOJ-00073O-AB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dAFOI-0000CO-Gw
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:46:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
References: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
Date: Mon, 15 May 2017 14:46:15 +0200
Message-ID: <w51shk6s2y0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Test streaming with missing
 job ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: kchamart@redhat.com, qemu-devel@nongnu.org

On Mon 15 May 2017 02:39:40 PM CEST, Kevin Wolf wrote:
> This adds a small test for the image streaming error path for failing
> block_job_create(), which would have found the null pointer dereference
> in commit a170a91f.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/030     | 4 ++++
>  tests/qemu-iotests/030.out | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index e00c11b..feee861 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -147,6 +147,10 @@ class TestSingleDrive(iotests.QMPTestCase):
>          result = self.vm.qmp('block-stream', device='nonexistent')
>          self.assert_qmp(result, 'error/class', 'GenericError')
>  
> +    def test_job_id_missing(self):
> +        result = self.vm.qmp('block-stream', device='mid')
> +        self.assert_qmp(result, 'error/class', 'GenericError')

Mmm... but does that trigger the bug?

The bug happens if the user tries to create a stream job on a BDS that:

a) exists
b) is not the active node (i.e. needs reopening in read-write mode)
c) its node name is not valid for a block job (e.g. it contains a '#')

Berto
