Received: from eggs.gnu.org ([2001:4830:134:3::10]:41067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gCrUg-0002dO-Tw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gCrUc-0004mj-5r
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:28:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gCrUb-0004kS-RZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:28:30 -0400
Date: Wed, 17 Oct 2018 15:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181017192826.GA7385@flamenco>
References: <20181011192513.63634-1-dgilbert@redhat.com>
	<20181011192513.63634-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011192513.63634-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/7] tests/migration: Enable the migration
 test on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, wei@redhat.com, i.maximets@samsung.com, thuth@redhat.com, den@openvz.org

On Thu, Oct 11, 2018 at 20:25:08 +0100, Dr. David Alan Gilbert (git) wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We can re-use the s390-ccw bios code to implement a small firmware
> for a s390x guest which prints out the "A" and "B" characters and
> modifies the memory, as required for the migration test.
> 
> [quintela: Converted the compile script to Makefile rules]
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1539078677-25396-1-git-send-email-thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>   Fixed up Makefile since the aarch patch sneaked in first

I suspect this test is giving me intermittent hangs. I've seen the hangs
in different machines, but when they're lightly loaded the
hang happens more frequently.

To reproduce:

$ ./configure --target-list=s390x-softmmu
$ make clean && make
$ for i in $(seq 0 150); do echo $i && make -j check-qtest || break; done

It usually ends up hanging before 50 runs. When the hang happens, I see
two qemu-system-s390x processes with:

-serial file:/tmp/migration-test-0FZErQ/dest_serial

as an argument, among others. That means the migration test is the
one hanging, correct?

Attaching with gdb just shows the TCG thread waiting for work
in qemu_tcg_rr_wait_io_event.

Can anyone reproduce this? Otherwise, let me know what other info
I could provide.

Thanks,

		Emilio
