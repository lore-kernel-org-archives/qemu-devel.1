Received: from eggs.gnu.org ([2001:4830:134:3::10]:33478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cniiU-0005oZ-R7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cniiQ-0002Nx-HB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:26:06 -0400
Date: Tue, 14 Mar 2017 10:25:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314092549.GA3952@noname.str.redhat.com>
References: <20170314090922.28083-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314090922.28083-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: clean up max_segments buffer
 termination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

Am 14.03.2017 um 10:09 hat Stefan Hajnoczi geschrieben:
> The following pattern is unsafe:
> 
>   char buf[32];
>   ret = read(fd, buf, sizeof(buf));
>   ...
>   buf[ret] = 0;
> 
> If read(2) returns 32 then a byte beyond the end of the buffer is
> zeroed.
> 
> In practice this buffer overflow does not occur because the sysfs
> max_segments file only contains an unsigned short + '\n'.  The string is
> always shorter than 32 bytes.
> 
> Regardless, avoid this pattern because static analysis tools might
> complain and it could lead to real buffer overflows if copy-pasted
> elsewhere in the codebase.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Oops. I should have found this during review. Thanks for catching it.

Thanks, applied to the block branch.

Kevin
