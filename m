Received: from eggs.gnu.org ([2001:4830:134:3::10]:49543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBKwG-0000OG-Uk
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBKwB-0003ok-5w
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:58:29 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1524633715-21393-1-git-send-email-thuth@redhat.com>
Message-ID: <df3914ed-ffda-b67d-3b61-9d740bf1ecec@redhat.com>
Date: Wed, 25 Apr 2018 15:58:15 +0200
MIME-Version: 1.0
In-Reply-To: <1524633715-21393-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] hw/s390x: Allow to
 configure the consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

On 25.04.2018 07:21, Thomas Huth wrote:
> The consoles ("sclpconsole" and "sclplmconsole") can only be configured
> with "-device" and "-chardev" so far. Other machines use the convenience
> option "-serial" to configure the default consoles, even for virtual
> consoles like spapr-vty on the pseries machine. So let's support this
> option on s390x, too. This way we can easily enable the serial console
> here again with "-nodefaults", for example:
> 
> qemu-system-s390x -no-shutdown -nographic -nodefaults -serial mon:stdio
> 
> ... which is way shorter than typing:
> 
> qemu-system-s390x -no-shutdown -nographic -nodefaults \
>   -chardev stdio,id=c1,mux=on -device sclpconsole,chardev=c1 \
>   -mon chardev=c1
> 
> The -serial parameter can also be used if you only want to see the QEMU
> monitor on stdio without using -nodefaults, but not the console output.
> That's something that is pretty impossible with the current code today:
> 
> qemu-system-s390x -no-shutdown -nographic -serial none
> 
> While we're at it, this patch also maps the second -serial option to the
> "sclplmconsole", so that there is now an easy way to configure this second
> console on s390x, too, for example:
> 
> qemu-system-s390x -no-shutdown -nographic -serial null -serial mon:stdio
> 
> Additionally, the new code is also smaller than the old one and we have
> less s390x-specific code in vl.c :-)
> 
> I've also checked that migration still works as expected by migrating
> a guest with console output back and forth between a qemu-system-s390x
> that has this patch and an instance without this patch.

... but I missed to run "make check" ... mea culpa. I need to update
tests/boot-serial-test.c now that we support -serial on s390x ... will
send a v2 with the fix.

 Thomas
