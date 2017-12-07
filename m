Received: from eggs.gnu.org ([2001:4830:134:3::10]:37479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eMzLn-0000uV-DA
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eMzLi-0000ot-Lf
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eMzLi-0000oC-EQ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:48:38 -0500
Date: Thu, 7 Dec 2017 17:48:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171207174832.42663bef@redhat.com>
In-Reply-To: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 7 Dec 2017 16:05:50 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Hi; I'm currently writing '-cpu max' support for ARM. For that I'd
> like to be able to do the "probe host kernel for its supported feature
> set" in the CPU object's instance-init function, but I'd like to do
> it just once and cache the answer. Can I rely on something or other
> having the BQL or otherwise ensuring that two threads don't run
> the instance_init method in parallel (eg in a hotplug situation),
> or do I need to create and use my own mutex to protect the cached
> answer data?
considering cached data shouldn't change during qemu lifetime it
shouldn't be possible for instance_init() to clash at hotplug
time as object_new(cpu) calls serialized within monitor/qmp loop.

But why cpu's instance_init, we could cache host's value at
configure_accelerator() time (could be different depending on accel).

CCing Eduardo as he is the one who worked on -cpu max for x86
(If I recall correctly)


> 
> thanks
> -- PMM
> 
