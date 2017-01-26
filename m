Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWiwQ-0003r2-Nk
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWiwN-0005f5-Fr
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:14:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43420
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cWiwN-0005ei-Ar
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:14:11 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0QCDrph065623
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 07:14:08 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 287ccma8ck-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 07:14:08 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 26 Jan 2017 12:14:06 -0000
Date: Thu, 26 Jan 2017 13:14:02 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170125144420.GE2096@work-vm>
References: <20170124184742.1639-1-dgilbert@redhat.com>
	<20170124184742.1639-3-dgilbert@redhat.com>
	<20170125114620.GA9699@lemon.Home> <20170125120053.GA2096@work-vm>
	<20170125131917.32df62ef.cornelia.huck@de.ibm.com>
	<20170125132254.GB2096@work-vm>
	<20170125152014.2ab6f901.cornelia.huck@de.ibm.com>
	<20170125144420.GE2096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170126131402.547f1004.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 02/15] migration: extend VMStateInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Jianjun Duan <duanj@linux.vnet.ibm.com>

On Wed, 25 Jan 2017 14:44:20 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> > On Wed, 25 Jan 2017 13:22:55 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > 
> > > * Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> > > > On Wed, 25 Jan 2017 12:00:53 +0000
> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> > > > > OK, so it looks like that's a failure path, adding a return -ENOMEM would seem to make
> > > > > sense there.
> > > > 
> > > > Just saw this. I don't think we want -ENOMEM, as that would change the
> > > > actual state being saved, no?
> > > 
> > > But isn't that the intention of this function?
> > > 
> > >     buf = g_try_malloc0(len);
> > >     if (!buf) {
> > >         /* Storing FLIC_FAILED into the count field here will cause the
> > >          * target system to fail when attempting to load irqs from the
> > >          * migration state */
> > >         error_report("flic: couldn't allocate memory");
> > >         qemu_put_be64(f, FLIC_FAILED);
> > >         return;
> > >     }
> > > 
> > > What should happen on the destination - should the migration fail?
> > > If we want the migration to fail then we should now return an error
> > > status rather than 0, and then we see a failed migration on the source
> > > as well.
> > 
> > Yes. There's also another error case below where we should return an
> > error instead of putting FLIC_FAILED, then.
> > 
> > The problem is that this is rather hard to test: So I'd prefer to fix
> > the compile for now and introduce error return codes in a separate
> > patch.
> 
> OK, that's fair.

I've coded something up and tried to test it with error injection to
trigger the failed case, but I can't really see an improvement :(

Before: source logs error, target fails to load the flic with 'invalid
argument'

After: source logs error, target fails to load the flic with 'could not
allocate memory'

The migration code does not seem to do anything with the return code of
put methods for now, so that's not too surprising. Is anything in the
works?

For now, I'd prefer to keep the old behaviour as 'invalid argument'
seems like a more obvious error on the target.

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index e86a84e49a..3c62ef8258 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -293,27 +293,21 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
     int len = FLIC_SAVE_INITIAL_SIZE;
     void *buf;
     int count;
+    int r = 0;
 
     flic_disable_wait_pfault((struct KVMS390FLICState *) opaque);
 
     buf = g_try_malloc0(len);
     if (!buf) {
-        /* Storing FLIC_FAILED into the count field here will cause the
-         * target system to fail when attempting to load irqs from the
-         * migration state */
         error_report("flic: couldn't allocate memory");
-        qemu_put_be64(f, FLIC_FAILED);
-        return 0;
+        return -ENOMEM;
     }
 
     count = __get_all_irqs(flic, &buf, len);
     if (count < 0) {
         error_report("flic: couldn't retrieve irqs from kernel, rc %d",
                      count);
-        /* Storing FLIC_FAILED into the count field here will cause the
-         * target system to fail when attempting to load irqs from the
-         * migration state */
-        qemu_put_be64(f, FLIC_FAILED);
+        r = count;
     } else {
         qemu_put_be64(f, count);
         qemu_put_buffer(f, (uint8_t *) buf,
@@ -321,7 +315,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
     }
     g_free(buf);
 
-    return 0;
+    return r;
 }
 
 /**
