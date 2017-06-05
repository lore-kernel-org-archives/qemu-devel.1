Received: from eggs.gnu.org ([2001:4830:134:3::10]:45074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHpUR-0002R2-EA
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHpUN-0001w6-4f
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHpUM-0001v9-Vu
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:43:59 -0400
References: <20170602081120.3497-1-famz@redhat.com>
	<CAFEAcA-PFs2hXqoGjqVpif2JQUqBcwdVj7U95=YDU0tCqGfuSA@mail.gmail.com>
	<20170602213015.GA27524@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6de62457-9674-1b90-72e0-9ea77b814bc9@redhat.com>
Date: Mon, 5 Jun 2017 12:43:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170602213015.GA27524@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>



On 02/06/2017 23:30, Fam Zheng wrote:
> Cc'ing Paolo.
> 
> On Fri, 06/02 16:50, Peter Maydell wrote:
>> On 2 June 2017 at 09:10, Fam Zheng <famz@redhat.com> wrote:
>>> The following changes since commit 43771d5d92312504305c19abe29ec5bfabd55f01:
>>>
>>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-31' into staging (2017-06-01 16:39:16 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>>>
>>> for you to fetch changes up to 4ab2cbc128f1938355a12970c9b6e419a63fcab6:
>>>
>>>   block: make accounting thread-safe (2017-06-02 15:59:32 +0800)
>>>
>>> ----------------------------------------------------------------
>>>
>>> v2: Fix building on OSX and BSD.

Seems to be a latent bug:

diff --git a/blockdev.c b/blockdev.c
index 34a20d3b9a..7b54d43896 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -564,6 +564,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         blk_rs->read_only     = read_only;
         blk_rs->detect_zeroes = detect_zeroes;
 
+        block_acct_init(blk_get_stats(blk), account_invalid, account_failed);
+
         QDECREF(bs_opts);
     } else {
         if (file && !*file) {

I'll shortly send it as a separate patch.

Thanks,

Paolo
