Received: from eggs.gnu.org ([2001:4830:134:3::10]:41522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cikBa-0007AA-1j
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cikBZ-0004i7-3R
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:59:34 -0500
References: <1488293711-14195-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <516283e2-27bc-83a3-de86-1df72f2daad2@redhat.com>
Date: Tue, 28 Feb 2017 16:59:23 +0100
MIME-Version: 1.0
In-Reply-To: <1488293711-14195-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] handle reparenting of SD cards for rpi2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Clement Deschamps <clement.deschamps@antfield.fr>



On 28/02/2017 15:55, Peter Maydell wrote:
> These patches are a respin of Clement's work on the
> rpi2 sd controller/gpio. They fix the valgrind issue that
> I was seeing because we got reparenting of the card wrong.
> 
> This patchset adds a new qdev patch which makes the
> qdev_set_parent_bus() function do most of the work of
> unplugging and replugging if the device was already on
> a bus. In particular it calls bus_remove_child() which does
> a lot of things that the previous "just call object_unparent"
> attempt didn't do.
> 
> Comments on whether this makes sense to people welcome.
> I'm still kind of hoping we can squeeze this into 2.9;
> comments on whether that would be unwise also welcome.

Looks good.  My first reaction was to add an assertion in
qdev_set_parent_bus, modify it to handle qdev_set_parent_bus(dev, NULL),
and then do a two-step unplug+replug in the raspi device models.

However, who knows what you could unleash when adding that assertion...

Paolo
