Received: from eggs.gnu.org ([2001:4830:134:3::10]:48314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWLG0-00030u-Jf
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWLFz-00026C-55
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWLFy-00025m-Sn
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:56:51 -0500
Date: Wed, 25 Jan 2017 10:56:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170125105643.GA15529@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-2-berrange@redhat.com>
	<c070ecd4-77e9-f4fd-fab6-c51b50220aa2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c070ecd4-77e9-f4fd-fab6-c51b50220aa2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] make: move top level dir to end of
 include search path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jan 24, 2017 at 02:11:29PM -0600, Eric Blake wrote:
> On 01/24/2017 05:01 AM, Daniel P. Berrange wrote:
> > Currently the search path is
> > 
> >   1. source dir corresponding to input file (implicit by compiler)
> >   2. top level build dir
> >   3. top level source dir
> >   4. top level source include/ dir
> >   5. source dir corresponding to input file
> >   6. build dir corresponding to output file
> > 
> > This causes a semantic difference in behaviour for builds
> > where srcdir == builddir vs srcdir != builddir, because
> > item 5 moves from end to start, when srcdir == builddir.
> 
> Rather, item 5 is a no-op (because it duplicated 1), and item 6 moves
> from the end to the beginning when srcdir == builddir

Yes

> > As a general rule we also want to move to have all shared
> > headers in the include/ dir, so move that ahead of the
> > top level dirs in the search order.
> 
> Wait - are you proposing that you swap 4 to occur earlier than 2/3?...

Sigh, left over from an earlier version of this patch. I was trying
todo a more general cleanup as described here, but decided to cut
back to the bare minimum I needed for trace work.

> > Thus we now have:
> > 
> >   1. source dir corresponding to input file
> >   2. build dir corresponding to output file
> >   3. top level build dir
> >   4. top level source dir
> >   5. top level source include/ dir
> 
> ...because this doesn't match that swap, and I don't see it in the patch
> body (but I may have missed it; I'm not as strong at reviewing make as I
> am at C)

Yeah, you're right.

> > 
> > and items 1+2 and 4+5 collapse into a single dir when srcdir==builddir
> 
> Isn't that items 3+4 (not 4+5) that collapse?

Yes, typo.

> > so overall order remains the same.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  rules.mak | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> 
> > 
> > diff --git a/rules.mak b/rules.mak
> > index d5c516c..e09aabe 100644
> > --- a/rules.mak
> > +++ b/rules.mak
> > @@ -26,8 +26,10 @@ QEMU_CXXFLAGS = -D__STDC_LIMIT_MACROS $(filter-out -Wstrict-prototypes -Wmissing
> >  # Flags for dependency generation
> >  QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> >  
> > -# Same as -I$(SRC_PATH) -I., but for the nested source/object directories
> > -QEMU_INCLUDES += -I$(<D) -I$(@D)
> 
> In particular, this is the old code for 5 and 6,
> 
> > +# Compiler searches the source file dir first, but in vpath builds
> > +# we need to make it search the build dir too, before any other
> > +# explicit search paths.
> > +QEMU_LOCAL_INCLUDES = -I$(BUILD_DIR)/$(@D)
> 
> while this is the new code for 2, plus documentation that 1 is implicit.

So there's a subtle difference I didn't explain, and which I'm going to
tweak again.

 -I$(@D)

is a relative include. eg for a file 'migration/ram.o' it will resolve
to '-Imigration' relative to the build dir. Except there's a subtle
difference between target-dependent and target-independent files. For
example, migration/migration.o will be built in $BUILD_DIR/migration
but migration/ram.o will be built in $BUILD_DIR/x86_64-softmmu/migration
so this reslative include points to two different places potentially.

Hence, I changed to -I$(BUILD_DIR)/$(@D), so it is gauranteed to
point to $BUILD_DIR/migration, even for target-dependant files.

In retrospect, I think it is more correct to include both directories
ie  -I$(BUILD_DIR)/$(@D) and -I$(@D). Even if not technically needed
by this patch series I think its clearer.

> >  WL_U := -Wl,-u,
> >  find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
> > @@ -61,7 +63,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
> >                    $(filter-out %.o %.mo,$1))
> >  
> >  %.o: %.c
> > -	$(call quiet-command,$(CC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
> > +	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
> 
> And the pre-pending of QEMU_LOCAL_INCLUDES is what changes the position
> of the local directory from last to first, thus delaying the top level
> dir to the end, but I don't see top/include/ moving.
> 
> These are now some long lines; is it worth taking the time to add \ line
> splitting for legibility, either in this patch or as an add-on?
> 
> > @@ -359,6 +361,7 @@ define unnest-vars
> >                  $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
> >                  $(error $o added in $v but $o-objs is not set)))
> >          $(shell mkdir -p ./ $(sort $(dir $($v))))
> > +        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
> >          # Include all the .d files
> 
> Okay, this change makes sense (make sure all the build directories exist
> in time; no-op for in-tree build, but helpful for VPATH), but seems
> unrelated to the commit message.  Rebase snafu?

The existing mkdir line there ensures that the -I$(@D) always points to a
directory that exists.

The new mkdir line does the same for -I$(BUILD_DIR)/$(@D).

This is to deal with fact that the compiler warns if you give a -I directory
that does not exist

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
