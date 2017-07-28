Received: from eggs.gnu.org ([2001:4830:134:3::10]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db4n9-0008A1-Eh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db4n8-0004Fl-NB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:54:55 -0400
Date: Fri, 28 Jul 2017 14:54:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170728125446.GE3983@localhost.localdomain>
References: <20170709170614.24967-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709170614.24967-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] block/vmdk: Report failures in
 vmdk_read_cid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

Am 09.07.2017 um 19:06 hat Peter Maydell geschrieben:
> The function vmdk_read_cid() can fail if the read on the underlying
> block device fails, or if there's a format error in the VMDK file.
> However its API doesn't provide a mechanism to report these errors,
> and in some cases we were returning a CID of 0 and in some cases a
> CID of 0xffffffff, either of which might potentially be valid values.
> 
> Change the function to return 0 on success or a negative errno, and
> return the CID via a uint32_t* argument. Update the callsites to
> handle and propagate the error appropriately.
> 
> This fixes in passing a Coverity-spotted issue (CID 1350038) where
> we weren't checking the return value from sscanf().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Fam, this is the commit that introduced the qemu-iotests 059 failure for
vmdk. I think what's happening is that we use an image produced by a
fuzzer, and with the additional checks introduced in this patch, we now
fail earlier and don't test the condition any more that we wanted to
test.

So do we need a new version of sample_images/afl9.vmdk.bz2 that has a
valid CID?

Kevin
