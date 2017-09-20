Received: from eggs.gnu.org ([2001:4830:134:3::10]:58092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dufrx-0000Yp-3m
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dufrt-0007KY-2l
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dufrs-0007Jr-Oq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:20:48 -0400
Date: Wed, 20 Sep 2017 15:20:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170920142040.GE2449@work-vm>
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-6-dgilbert@redhat.com>
	<20170920035512.GF18491@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920035512.GF18491@lemon>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

* Fam Zheng (famz@redhat.com) wrote:
> On Tue, 09/19 19:00, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > vmstate_save is called in a few places, and vmstate_save_state is
> > called in lots of places.
> > 
> > Route error returns from the easier cases back up;  there are lots
> > of more complex cases where there own error paths need fixing.
> 
> Did you mean s/there/their/ ?

I do; thanks.

> <snip>
> 
> > diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> > index e643ac662b..ab3e430c2c 100644
> > --- a/tests/test-vmstate.c
> > +++ b/tests/test-vmstate.c
> > @@ -70,7 +70,7 @@ static void save_vmstate(const VMStateDescription *desc, void *obj)
> >      QEMUFile *f = open_test_file(true);
> >  
> >      /* Save file with vmstate */
> > -    vmstate_save_state(f, desc, obj, NULL);
> > +    g_assert(!vmstate_save_state(f, desc, obj, NULL));
> 
> Though this is test code, isn't putting anything with a side effect into an
> assert expression a very bad pattern in general?

Hmm; ok I've changed this but I'm not really convinced; the whole point
of an asser in a test is to actually run it, and I think the g_assert
prints the text that failed, so it gives you a much better error inline.

Dave

> >      qemu_put_byte(f, QEMU_VM_EOF);
> >      g_assert(!qemu_file_get_error(f));
> >      qemu_fclose(f);
> > @@ -381,7 +381,7 @@ static void test_save_noskip(void)
> >      QEMUFile *fsave = open_test_file(true);
> >      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
> >                         .skip_c_e = false };
> > -    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> > +    g_assert(!vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL));
> >      g_assert(!qemu_file_get_error(fsave));
> >  
> >      uint8_t expected[] = {
> > @@ -402,7 +402,7 @@ static void test_save_skip(void)
> >      QEMUFile *fsave = open_test_file(true);
> >      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
> >                         .skip_c_e = true };
> > -    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> > +    g_assert(!vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL));
> >      g_assert(!qemu_file_get_error(fsave));
> >  
> >      uint8_t expected[] = {
> > -- 
> > 2.13.5
> > 
> > 
> 
> Fam
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
