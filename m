Received: from eggs.gnu.org ([2001:4830:134:3::10]:58768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fwnkC-00065n-Go
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fwnk7-0001xw-FS
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:14:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fwnk7-0001xW-1c
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:14:07 -0400
Date: Mon, 3 Sep 2018 14:14:01 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180903121401.ncz2n7rlahh6xtat@kamzik.brq.redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-2-git-send-email-wei@redhat.com>
	<20180903110813.hbamu4zuda6qpwuw@kamzik.brq.redhat.com>
	<87k1o23iua.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1o23iua.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH V8 1/4] tests/migration: Convert x86 boot
 block compilation script into Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Wei Huang <wei@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, peter.maydell@linaro.org

On Mon, Sep 03, 2018 at 01:45:33PM +0200, Juan Quintela wrote:
> Andrew Jones <drjones@redhat.com> wrote:
> > On Sat, Sep 01, 2018 at 01:11:12AM -0400, Wei Huang wrote:
> >> The x86 boot block header currently is generated with a shell script.
> >> To better support other CPUs (e.g. aarch64), we convert the script
> >> into Makefile. This allows us to 1) support cross-compilation easily,
> >> and 2) avoid creating a script file for every architecture.
> >> 
> >> Note that, in the new design, the cross compiler prefix can be specified by
> >> setting the CROSS_PREFIX in "make" command. Also to allow gcc pre-processor
> >> to include the C-style file correctly, it also renames the
> >> x86-a-b-bootblock.s file extension from .s to .S.
> >> + * tests/migration/rebuild-x86-bootblock.sh to update,
> >> + * and then remember to send both in your patch submission.
> >> + */
> >> +endef
> >> +export __note
> >> +
> >> +.PHONY: all clean
> >> +all: x86-a-b-bootblock.h
> >> +
> >> +x86-a-b-bootblock.h: x86.bootsect
> >> +	echo "$$__note" > header.tmp
> >> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
> >> +	mv header.tmp $@
> >
> > The shell script this Makefile is replacing used mktemp
> > for a randomly named tmp dir. Shouldn't we continue to
> > use random names?
> 
> We shouldn't be trying to create the file twice in parallel, no?

Yeah, you're right. This should be safe.

> 
> >
> >> +
> >> +x86.bootsect: x86.boot
> >> +	dd if=$< of=$@ bs=256 count=2 skip=124
> >> +
> >> +x86.boot: x86.o
> >> +	$(CROSS_PREFIX)objcopy -O binary $< $@
> >> +
> >> +x86.o: x86-a-b-bootblock.S
> >> +	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
> >> +
> >> +clean:
> >> +	@rm -rf *.boot *.o *.bootsect
> >
> > We don't want to remove the generated header file when cleaning?
> 
> No, because we only generated the header file when running native, have
> the right crosscompilers, etc.  In general we only recompile it when we
> change the test file, otherwise we store the generated ones.
> 
> Idea is:
> We have a c file that does what we want.
> We compile it (when we have a propper compiler) and store it on the
> tree.
> We compile it for each test.
> 
> This is more "like firmware" than normal "qemu" source code.
>

Right. I momentarily forget that when replying to this patch.

Thanks,
drew
