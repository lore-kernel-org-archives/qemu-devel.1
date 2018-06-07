Received: from eggs.gnu.org ([2001:4830:134:3::10]:42039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQq3f-0008Vp-Ln
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQq3b-0008So-JN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:14:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59698 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQq3b-0008SW-CX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:14:07 -0400
Date: Thu, 7 Jun 2018 16:13:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607081359.GF750@xz-mi>
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-5-peterx@redhat.com>
	<5706d352-39d8-9a06-5d25-bba4da747cd9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5706d352-39d8-9a06-5d25-bba4da747cd9@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 4/4] Revert "tests: Add parameter to
 qtest_init_without_qmp_handshake"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 31, 2018 at 09:51:00AM -0500, Eric Blake wrote:
> On 05/31/2018 12:16 AM, Peter Xu wrote:
> > This reverts commit ddee57e0176f6ab53b13c6c97605b62737a8fd7a.
> > 
> > Meanwhile, revert one line from fa198ad9bdef to make sure
> > qtest_init_without_qmp_handshake() will only pass in one parameter.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> > +++ b/tests/libqtest.h
> > @@ -56,14 +56,11 @@ QTestState *qtest_init(const char *extra_args);
> >   /**
> >    * qtest_init_without_qmp_handshake:
> > - * @use_oob: true to have the server advertise OOB support
> > - * @extra_args: other arguments to pass to QEMU.  CAUTION: these
> > - * arguments are subject to word splitting and shell evaluation.
> > + * @extra_args: other arguments to pass to QEMU.
> 
> The CAUTION message was a useful improvement, I don't think we should revert
> that part of the patch.
> 
> > @@ -200,13 +199,12 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
> >           command = g_strdup_printf("exec %s "
> >                                     "-qtest unix:%s,nowait "
> >                                     "-qtest-log %s "
> > -                                  "-chardev socket,path=%s,nowait,id=char0 "
> > -                                  "-mon chardev=char0,mode=control%s "
> > +                                  "-qmp unix:%s,nowait "
> >                                     "-machine accel=qtest "
> >                                     "-display none "
> >                                     "%s", qemu_binary, socket_path,
> >                                     getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
> > -                                  qmp_socket_path, use_oob ? ",x-oob=on" : "",
> > +                                  qmp_socket_path,
> 
> I agree with your cover letter that you don't want to check in patch 3/4
> as-is, as it temporarily breaks this test.  But I disagree with your idea of
> squashing 3 and 4 into one patch, as having two separate reversion patches
> that both call out the primary commit that they are reverting is nicer than
> one patch that reverts two things at once.  My suggestion: in patch 3, tweak
> this line to be:
> 
> qmp_socket_path, "",
> 
> so that the test will pass, then in patch 4, remove the useless "" parameter
> (a minor conflict resolution rather than a clean revert, but we already have
> that because of fa198ad9b, and I think it results in a nicer git commit
> history).

Will take your suggestion.

I'll wait a bit more to see what's the conclusion for "[PATCH]
monitor: postpone monitor_qmp_cleanup_queues" before I repost.

Thanks for the review.

-- 
Peter Xu
