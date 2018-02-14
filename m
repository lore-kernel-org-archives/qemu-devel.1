Received: from eggs.gnu.org ([2001:4830:134:3::10]:51316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyiR-0004mO-TN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyiN-000656-4l
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:11:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elyiM-00064N-Mz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:11:18 -0500
References: <201297396.3423395.1518598461012.JavaMail.zimbra@oxygem.tv>
	<1564471998.3427173.1518601541505.JavaMail.zimbra@oxygem.tv>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83c0fdee-126f-18f1-a691-053669325cb9@redhat.com>
Date: Wed, 14 Feb 2018 09:11:02 -0600
MIME-Version: 1.0
In-Reply-To: <1564471998.3427173.1518601541505.JavaMail.zimbra@oxygem.tv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] drive-mirroring to nbd is failing with multiple
 parallel jobs (qemu 2.9 -> 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, nbd list <nbd@other.debian.org>

[adding nbd list]

On 02/14/2018 03:45 AM, Alexandre DERUMIER wrote:
> Sorry, I just find that the problem is in our proxmox implementation,
> 
> as we use a socat tunnel for the nbd mirroring, with a timeout of 30s in case of inactivity.
> 
> So, not a qemu bug.

Good to hear. Still, it makes me wonder if the NBD protocol itself 
should have some sort of a keepalive mechanism, maybe a new NBD_CMD_PING 
that can be used as a no-op command to keep the line alive if there is 
no other command to send for a while?  A client can always use a 
throwaway NBD_CMD_READ to keep the line alive, but that has more 
overhead; conversely, an extension is only useful if both client and 
server can negotiate to use it, which means that clients still have to 
be prepared for alternative fallbacks if they want to keep the line 
alive.  And we still don't have support for the server ever sending 
unsolicited messages (other than perhaps a structured reply where the 
server sends periodic reply chunks but never sends a final chunk - but 
still something that the guest initiates the sequence of server 
replies), so while the guest can keep the line to the server up, having 
the server keep the line open to the guest is a bit harder.

This is more food for thought on whether it even makes sense for NBD to 
worry about assisting in keepalive matters, or whether it would just be 
bloating the protocol.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
