Received: from eggs.gnu.org ([2001:4830:134:3::10]:52480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coYqT-0004L3-Q5
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coYqQ-0001Sg-0L
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coYqP-0001RN-Qj
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:05:45 -0400
Date: Thu, 16 Mar 2017 17:05:40 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170316170540.GE15193@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <8fb8ed45-6de3-2b74-f5ea-44b374cabcbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fb8ed45-6de3-2b74-f5ea-44b374cabcbd@gmail.com>
Subject: Re: [Qemu-devel] Make qemu_thread_create return a flag to indicate
 if it succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Achilles Benetopoulos <abenetopoulos@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Mar 16, 2017 at 06:55:47PM +0200, Achilles Benetopoulos wrote:
> I am interested in working on the BiteSized Task mentioned in the
> subject line. However, I have a question: Since the current behaviour
> of qemu_thread_create is to fail in the case of an error, then it
> seems logical to make the caller exit (in the patched version) if the
> return value of the call to qemu_thread_create indicates an error. Is
> this desirable? If so, how detailed should the error messages reported
> be? If not, then I'm guessing that the desired behaviour is a more
> graceful handling of the error on a case-by-case basis?

I imagine it would be a two stage conversion. First add an 'Error **errp'
parameter ot the qemu_thread_create() API which gets set on failure. Have
all the callers check this error & exit if set. This is the easy bit.

Second stage is to actually make the callers propagate the error back up
their call stack, so we can avoid exiting QEMU entirely in appropriate cases.
This takes a little more investigation to figure out optimal behaviour for
each of the callers

eg, if we tried to add an I/O thread to an existing running guest, we don't
want QEMU to exit. We just want the error reported back up to the monitor
so the mgmt app can handle it.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
