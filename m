Received: from eggs.gnu.org ([2001:4830:134:3::10]:43589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duIY0-00013f-8g
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duIXu-0003bO-Ac
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:26:44 -0400
Date: Tue, 19 Sep 2017 14:26:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919132627.GN9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170919102434.21147-1-pbonzini@redhat.com>
	<20170919102434.21147-5-pbonzini@redhat.com>
	<20170919125300.GL9536@redhat.com>
	<d80b9409-9524-4a05-d0a3-d3e8f23c416b@redhat.com>
	<20170919131208.GM9536@redhat.com>
	<ddc23258-0e68-f2e3-72a3-c16e443a7143@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddc23258-0e68-f2e3-72a3-c16e443a7143@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] scsi: add persistent reservation
 manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Sep 19, 2017 at 03:23:09PM +0200, Paolo Bonzini wrote:
> On 19/09/2017 15:12, Daniel P. Berrange wrote:
> > On Tue, Sep 19, 2017 at 02:57:00PM +0200, Paolo Bonzini wrote:
> >> On 19/09/2017 14:53, Daniel P. Berrange wrote:
> >>>> +    /* Try to reconnect while sending the CDB.  */
> >>>> +    for (attempts = 0; attempts < PR_MAX_RECONNECT_ATTEMPTS; attempts++) {
> >>>
> >>> I'm curious why you need to loop here. The helper daemon should be running
> >>> already, as you're not spawning it on demand IIUC. So it shoudl either
> >>> succeed first time, or fail every time.
> >>
> >> You're focusing on the usecase where the helper daemon is spawned per-VM
> >> by the system libvirtd, which I agree is the most important one.
> >> However, the other usecase is the one with a global daemon, access to
> >> which is controlled via Unix permissions.  This is not SELinux-friendly,
> >> but it is nicer for testing and it is also the only possibility for user
> >> libvirtd.
> >>
> >> In that case, upgrading QEMU on the host could result in a "systemctl
> >> restart qemu-pr-helper.service" (or, hopefully unlikely, a crash could
> >> result in systemd respawning the daemon).  Reconnect is useful in that case.
> > 
> > If using systemd socket activation and you restart the daemon, the listening
> > socket should be preserved, so you shouldn't need to reconnect - the client
> > should get queued until it has started again (likewise on crash).
> 
> Oh, that's cool.  I didn't know that.  However, systemd socket
> activation is optional, and it's only a handful of lines so I think it's
> a bit nicer behavior (chardevs for example have options to reconnect).

The downside is that if someone forget to start the daemon, or enable
the socket,  QEMU will spin for 5 seconds trying to reconnect, instead
of reporting an error immediately. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
