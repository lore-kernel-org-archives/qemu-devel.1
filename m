Received: from eggs.gnu.org ([2001:4830:134:3::10]:40872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dO2lA-0000SI-Am
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dO2l8-0000eY-BS
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:07:00 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dO2l7-0000dv-Uj
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:06:58 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k67so24911275wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 07:06:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c8dbd37-073c-28a8-0062-272c6df02373@redhat.com>
References: <20170613125515.30416-1-vadim.galitsyn@profitbricks.com>
	<20170613125515.30416-2-vadim.galitsyn@profitbricks.com>
	<5c8dbd37-073c-28a8-0062-272c6df02373@redhat.com>
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Thu, 22 Jun 2017 16:06:34 +0200
Message-ID: <CAPHE7Nq=bRZ3XTkWEwWbW5WN2JPK7rwkeh7hb-g20ws6vQZwtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Hi David,

Thank you for the input. Please find my comments below.

> Is the idea to have something like hmp_info_numa() ("info NUMA"), just
> for qmp? And so it also works without NUMA?
..
> We also have query-memory-devices for that already.

The initial idea was to have a command for both HMP and QMP which would
report
a short summary regarding to memory which was assigned to a VM taking into
account
all the relevant "kinds" of memory (base/static, hot-plugged etc). Instead
of calling
"info memdev" + "info numa" + "info balloon" (if relevant) -- "info memory"
/ "query-memory"
can provide short summary within single monitor call. What do you think
about this in general?

> I don't think ballooning belongs into this at all.
..
> Can't you simply change query-balloon to show 0 in case no balloon is
> around? Or why can't your caller simply deal with the fact that querying
> the balloon might fail? Making a qmp interface directly copy the data
> from another qmp interface looks strange.

This can be removed from patch if it's confusing. The reason why it
appeared here is
the short discussion in https://lists.gnu.org/archive/
html/qemu-devel/2012-07/msg01472.html
where it was proposed.

> This seems to be x86 specific.
> Some machines (e.g. s390x) will not be properly accounted here.
> (e.g. they round ram_size up/down) or don't use DIMMs. I think we should
> query the machines instead.

In patch v3 (
http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03475.html)
the command reports zero hot-plugged memory on machines which have
CONFIG_MEM_HOTPLUG disabled. No error emitted for such machines. Patch was
submitted before I received input from you and of course v4 will consider
all the points.

> So what you could do:
>
> - total_base memory
> - total hotplugged memory
> - base_memory per NUMA node
> - hotplugged memory per NUMA node

I will provide an extra patch which will extend "info numa" output to
additionally provide
information about hot-plugged memory per NUMA node and current patch will
utilize
this functionality. Actual "info memory" command (as well as
"query-memory") will provide
information as you suggested.

Thank you,
Vadim


On Mon, Jun 19, 2017 at 9:47 AM, David Hildenbrand <david@redhat.com> wrote=
:

> On 13.06.2017 14:55, Vadim Galitsyn wrote:
> > Commands above provide the following memory information in bytes:
>
> Is the idea to have something like hmp_info_numa() ("info NUMA"), just
> for qmp? And so it also works without NUMA?
>
> I think, for this command to be helpful, you should include a per-NUMA
> node information.
>
> So what you could do:
>
> - total_base memory
> - total hotplugged memory
> - base_memory per NUMA node
> - hotplugged memory per NUMA node
>
> >
> >   * hot-plug-memory - amount of memory that was hot-plugged.
> >
>
> We also have query-memory-devices for that already.
>
> >   * ballooned-actual-memory - size of the memory that remains
> >     available to the guest after ballooning, as reported by the
> >     guest. If the guest has not reported its memory, this value
> >     equals to @base-memory + @hot-plug-memory. If ballooning
> >     is not enabled, zero value is reported.
>
> I don't think ballooning belongs into this at all.
>
> >
> > NOTE:
> >
> >     Parameter @ballooned-actual-memory reports the same as
> >     "info balloon" command when ballooning is enabled. The idea
> >     to have it in scope of this command(s) comes from
> >     https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html=
.
>
> Can't you simply change query-balloon to show 0 in case no balloon is
> around? Or why can't your caller simply deal with the fact that querying
> the balloon might fail? Making a qmp interface directly copy the data
> from another qmp interface looks strange.
>
> >
> > Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.co=
m
> >
> > Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
> > Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> > Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> > Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> [...]
> > +
> > +MemoryInfo *qmp_query_memory(Error **errp)
> > +{
> > +    MemoryInfo *mem_info =3D g_malloc0(sizeof(MemoryInfo));
> > +    BalloonInfo *balloon_info;
> > +    Error *local_err =3D NULL;
> > +
> > +    mem_info->base_memory =3D ram_size;
> > +    mem_info->hot_plug_memory =3D pc_existing_dimms_capacity(&local_er=
r);
>
> This seems to be x86 specific.
> Some machines (e.g. s390x) will not be properly accounted here.
> (e.g. they round ram_size up/down) or don't use DIMMs. I think we should
> query the machines instead.
>
> > +    if (local_err) {
> > +        error_setg(errp, "could not get hot-plug memory info: %s",
> > +                   error_get_pretty(local_err));
> > +        g_free(mem_info);
> > +        return NULL;
> > +    }
> > +
> > +    /* In case if it is not possible to get balloon info, just ignore
> it. */
> > +    balloon_info =3D qmp_query_balloon(&local_err);
> > +    if (local_err) {
> > +        mem_info->ballooned_actual_memory =3D 0;
> > +        error_free(local_err);
> > +    } else {
> > +        mem_info->ballooned_actual_memory =3D balloon_info->actual;
> > +    }
>
> --
>
> Thanks,
>
> David
>



--=20
Vadim Galitsin
Software Engineer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Fax:      +49 30 577 008 299
Email:    vadim.galitsyn@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss
