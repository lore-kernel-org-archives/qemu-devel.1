Received: from eggs.gnu.org ([2001:4830:134:3::10]:39726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cUGCV-0001rp-Gw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cUGCU-0000gt-GG
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:08:39 -0500
Date: Thu, 19 Jan 2017 18:08:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170119170830.GD5443@noname.redhat.com>
References: <50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
	<20170118095952.GA5258@noname.str.redhat.com>
	<566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
	<43209b10-7760-8df6-d5a9-d6b66bebc292@redhat.com>
	<20170119152029.GA5443@noname.redhat.com>
	<772ba40f-7748-6d6a-8d7f-28ebeab14ff4@kamp.de>
	<20170119154202.GB5443@noname.redhat.com>
	<314bb7a6-3c9e-c259-469c-20acfa20c144@kamp.de>
	<20170119155559.GC5443@noname.redhat.com>
	<97063398-5dab-a17f-253d-c0be1c34cfa8@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97063398-5dab-a17f-253d-c0be1c34cfa8@kamp.de>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] allow blockdev-add for NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Eric Blake <eblake@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 19.01.2017 um 16:58 hat Peter Lieven geschrieben:
> Am 19.01.2017 um 16:55 schrieb Kevin Wolf:
> >Am 19.01.2017 um 16:44 hat Peter Lieven geschrieben:
> >>Am 19.01.2017 um 16:42 schrieb Kevin Wolf:
> >>>Am 19.01.2017 um 16:34 hat Peter Lieven geschrieben:
> >>>>Am 19.01.2017 um 16:20 schrieb Kevin Wolf:
> >>>>>Am 19.01.2017 um 15:59 hat Eric Blake geschrieben:
> >>>>>>On 01/19/2017 08:30 AM, Peter Lieven wrote:
> >>>>>>>>>qemu-img: Could not open
> >>>>>>>>>'nfs://172.21.200.61/vcore-dev-cdrom/templates/VC_debian8-20170116.qcow2,linux?readahead=131072':
> >>>>>>>>>Block protocol 'nfs' doesn't support the option 'readahead-size'
> >>>>>>>>>
> >>>>>>>>>Please let me know if the below fix would be correct:
> >>>>>>>>No, this needs to be fixed the other way round: runtime_opts must use
> >>>>>>>>the names as specified in the schema, and nfs_client_open() must access
> >>>>>>>>them as such. Without that, blockdev-add can't work (and the command
> >>>>>>>>line only with the "wrong" old option names from the URL, whereas it
> >>>>>>>>should be using the same names as the QAPI schema).
> >>>>>>>Shouldn't we support both for backwards compatiblity.?
> >>>>>>blockdev-add only needs to support the modern naming.  But yes,
> >>>>>>preserving back-compat spelling of the command-line spellings, as well
> >>>>>>as matching blockdev-add spellings, is desirable.
> >>>>>We only just added the individual command line options, previously it
> >>>>>only supported the URL.
> >>>>>
> >>>>>It's true that we have the messed up version of the options in 2.8, so
> >>>>>strictly speaking we would break compatibility with a release, but it's
> >>>>>only one release, it's only the nfs driver, and the documentation of the
> >>>>>options is the schema, which had the right option names even in 2.8
> >>>>>(they just didn't work).
> >>>>>
> >>>>>So I wouldn't feel bad about removing the wrong names in this specific
> >>>>>case.
> >>>>So want exactly do you want to do? Fix the names in the QAPI schema
> >>>>to use the old naming?
> >>>No, fix the command line to use the names in the QAPI schema.
> >>>
> >>>The option names from the URL were never supposed to be supported on the
> >>>command line.
> >>Okay, so no backwards compatiblity? I actually used the options on the command line...
> >Well, do you _need_ compatibility?
> >
> >It can certainly be done, but as the (wrong) options on the command line
> >have only existed since November and were never documented, I wouldn't
> >bother unless there's a good reason.
> 
> Every Qemu before 2.8.0 was working with sth like:
> 
> qemu -cdrom nfs://10.0.0.1/expory/my.iso?readahead=131072

That will keep working. We're not changing the URL parsing, just the
runtime_opts and its accesses in nfs_client_open(). The translation in
nfs_parse_uri() stays intact with the fixes.

What will stop working (and only worked in 2.8.0) is this:

    qemu -drive media=cdrom,driver=nfs,server.host=10.0.0.1,path=export/my.iso,readahead=131072

Also, I think the fixes should be Cc: qemu-stable, so that 2.8.1 will
work correctly again.

Kevin
