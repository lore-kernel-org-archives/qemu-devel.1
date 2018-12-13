Received: from eggs.gnu.org ([2001:4830:134:3::10]:51147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXRoN-0006F1-7p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXRoF-0002Xd-VR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:17:59 -0500
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
Date: Thu, 13 Dec 2018 08:17:44 -0600
MIME-Version: 1.0
In-Reply-To: <DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Request for clarification on qemu-img convert
 behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nsoffer@redhat.com>, qemu block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Aamir T, Owais (Nokia - IN/Chennai)" <owais.aamir_t@nokia.com>

On 12/13/18 7:12 AM, De Backer, Fred (Nokia - BE/Antwerp) wrote:
> Hi,
> 
> We're using Openstack Ironic to deploy baremetal servers. During the deployment process an agent (ironic-python-agent) running on Fedora linux uses qemu-img to write a qcow2 file to a blockdevice.
> 
> Recently we saw a change in behavior of qemu-img. Previously we were using Fedora 27 containing a fedora packaged version of qemu-img v2.10.2 (qemu-img-2.10.2-1.fc27.x86_64.rpm); now we use Fedora 29 containing a fedora packaged version of qemu-img v3.0.0 (qemu-img-3.0.0-2.fc29.x86_64.rpm).
> 
> The command that is run by the ironic-python-agent (the same in both FC27 and FC29) is: qemu-img -t directsync -O host_device /tmp/image.qcow2 /dev/sda
> 
> We observe that in Fedora 29 the qemu-img, before imaging the disk, it fully zeroes it. Taking into account the disk size, the whole process now takes 35 minutes instead of 50 seconds. This causes the ironic-python-agent operation to time-out. The Fedora 27 qemu-img doesn't do that.

Known issue; Nir and Rich have posted a previous thread on the topic, 
and the conclusion is that we need to make qemu-img smarter about NOT 
requesting pre-zeroing of devices where that is more expensive than just 
zeroing as we go.
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg01182.html


> 
> Scanning through the qemu-img source code, we found that adding -S 0 to the command on Fedora 29 qemu-img restores the behavior as observed in Fedora 27 qemu-img.
> 
> Looking through the changelogs of qemu I couldn't find this behavior change documented.
> 
> Now the questions:
> * Is this the expected/required behavior that qemu-img first zeroes the complete target disk before writing the image. In other words: is this a qemu-img bug?

It's a performance bug. qemu-img convert has to ensure that the 
destination reads 0 (rather than is uninitialized), but the way in which 
it does so needs to be more careful about destinations that do not have 
efficient block status or bulk zeroing capabilities.

> * Is applying the -S 0 parameter a safe/sound/sensible thing to do to revert to the old behavior. In other words: can I write a bug against the ironic-python-agent to start using this parameter?

Using -S 0 avoids sparseness, which may introduce its own set of 
problems if you were expecting the destination to be sparse.

> * If the behavior is expected: is there some pointer to documentation/changelogs I can read about this?

Reading the mentioned thread will give some more insight, and hopefully 
qemu 4.0 will either improve the behavior by default or at least add 
knobs so that you can tweak the behavior based on your needs.

> This message (including any attachments) contains confidential information

Such disclaimers are unenforceable on publicly-archived lists.  Still, 
you may want to consider using a different email address that doesn't 
spam list readers with your employer's legalese gobbledygook.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
