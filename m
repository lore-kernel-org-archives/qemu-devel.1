Received: from eggs.gnu.org ([209.51.188.92]:57091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1goOrO-0000Zp-1u
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1goOrI-0008NN-12
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:35:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1goOrH-0008KQ-Qp
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:35:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so16666041wmi.4
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 00:35:01 -0800 (PST)
Date: Tue, 29 Jan 2019 09:34:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190129083457.vlapjf4ziqhyxjxf@steredhat>
References: <20190129062801.15799-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129062801.15799-1-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, xiaohli@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

On Tue, Jan 29, 2019 at 11:58:01AM +0530, Pankaj Gupta wrote:
> Hotplugging existing char chardev with qmp, dereferences(removes) 
> existing chardev. This patch avoids adding a chardev if a chardev 
> with same id exists.
> 
> RH BZ 1660831: 
> 
> # (host) ls -lt /tmp/helloworld*
> srwxr-xr-x.  /tmp/helloworld1
> srwxr-xr-x.  /tmp/helloworld2
> 
> Before this patch:
> 
> hotplug existed chardev(channel1) in qmp:
> {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type":"socket",
> "data":{"addr":{"type":"unix", "data": {"path": "/tmp/helloworld1"}}}}}}
> 
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate 
> property 'charchannel1' to object (type 'container')"}}
> 
> # ls -lt /tmp/helloworld*
> srwxr-xr-x. 1 root root 0 Dec 19 16:39 /tmp/helloworld2
> 
> After this patch:
> 
> {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type":"socket",
> "data":{"addr":{"type":"unix", "data": {"path": "/tmp/helloworld1"}}}}}}
> {"error": {"class": "GenericError", "desc": "Chardev 'charchannel1' already exists"}}
> 
> # ls -lt /tmp/helloworld*
> srwxr-xr-x. 1 /tmp/helloworld1
> srwxr-xr-x. 1 /tmp/helloworld2
>  
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
> 
> v1->v2
>  Correct error message - Eric 
> 
>  chardev/char.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
