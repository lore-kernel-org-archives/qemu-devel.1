Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cIzTl-0005k0-AB
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cIzTh-0004JX-AY
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:03:53 -0500
Received: from ip35.imatronix.com ([200.73.112.45]:46319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kripper@imatronix.cl>)
	id 1cIzTg-0004Id-0n
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:03:49 -0500
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
	<20161219135529.GE17374@stefanha-x1.localdomain>
From: Christopher Pereira <kripper@imatronix.cl>
Message-ID: <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
Date: Mon, 19 Dec 2016 12:03:41 -0300
MIME-Version: 1.0
In-Reply-To: <20161219135529.GE17374@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Fam, Stefan,

Thanks for answering.

We use "qemu-img convert" to convert a image in the middle of the chain, 
not the active one.
Those images (and the previous ones in the chain) are read-only and 
there should be no risk in converting them:

E.g.: for the following chain:

    base --> snap1 ---> snap2 ---> snap3 (active)

we do "qemu-img convert" on snap2 (readonly), generating a snap2' with 
the same content as snap2.

Then we do the rebase while the VM is suspended to make sure the image 
files are reopened.

Please confirm if I'm missing something here.

We are not using block-commit since we want to have more control (keep 
the base snapshot unmodified, use compression, etc).

Best regards,
Christopher

On 19-Dec-16 10:55, Stefan Hajnoczi wrote:
> On Mon, Dec 19, 2016 at 09:07:43AM +0800, Fam Zheng wrote:
>> On Sun, 12/18 20:52, Christopher Pereira wrote:
>>> Hi,
>>>
>>> We are doing a "qemu-img convert" operation (qcow2, with compression) to
>>> shorten the backing-chain (in the middle of the backing-chain).
>>> In order to force qemu to reopen files, we do a save and restore operation.
>>> Is there a faster way to reopen image files using virsh or qemu?
>> No, don't use qemu-img when the image is in use by QEMU. You want to use
>> "block-commit" command provided by QMP.
> It's worth being more explicit here:
>
> You will corrupt the image file if you access it with another program
> while QEMU is using it!
>
> Stefan
