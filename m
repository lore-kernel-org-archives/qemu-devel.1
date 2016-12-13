Received: from eggs.gnu.org ([2001:4830:134:3::10]:47176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGuMa-0001I4-4R
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGuMV-0007sf-1b
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGuMU-0007sY-RE
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:11:46 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 064E5A794
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 21:11:46 +0000 (UTC)
Date: Tue, 13 Dec 2016 19:11:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161213211143.GE3808@thinpad.lan.raisama.net>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-18-git-send-email-ehabkost@redhat.com>
	<87zik0qgm6.fsf@dusky.pond.sub.org>
	<20161213125547.GQ3808@thinpad.lan.raisama.net>
	<87shprljp4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87shprljp4.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/17] target-i386: Implement
 query-cpu-model-expansion QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org

On Tue, Dec 13, 2016 at 08:20:39PM +0100, Markus Armbruster wrote:
[...]
> >> > +    if (type ==  CPU_MODEL_EXPANSION_TYPE_STATIC) {
> >> > +        /* static expansion force migration-unsafe features off: */
> >> > +        ret->q_static = ret->migration_safe = true;
> >> > +        qdict_del(props, "pmu");
> >> > +        qdict_del(props, "host-cache-info");
> >> > +    } else if (type == CPU_MODEL_EXPANSION_TYPE_FULL) {
> >> > +        QObject *o;
> >> > +        /* full expansion clear the static/migration-safe flags
> >> > +         * to indicate migration-unsafe features are on:
> >> > +         */
> >> > +        ret->q_static = true;
> >> > +        ret->migration_safe = true;
> >> > +
> >> > +        o = qdict_get(props, "pmu");
> >> > +        if (o && qbool_get_bool(qobject_to_qbool(o))) {
> >> > +            ret->q_static = ret->migration_safe = false;
> >> > +        }
> >> > +        o = qdict_get(props, "host-cache-info");
> >> > +        if (o && qbool_get_bool(qobject_to_qbool(o))) {
> >> > +            ret->q_static = ret->migration_safe = false;
> >> > +        }
> >> > +    } else {
> >> > +        error_setg(&err, "The requested expansion type is not supported.");
> >> 
> >> How can this happen?
> >> 
> >> If it can, it bombs when x86_cpu_to_dict() already set an error (see
> >> "use of the error API" above).
> >
> > This can happen if we change the QAPI schema to support another
> > expansion type in the future.
> 
> I'd make this an assertion, because it's a programming error.

I don't think it's a programming error. For example, if one day
the ppc maintainers decide they need a new expansion type for
some arch-specific requirement they have, they won't need to
touch the x86 and s390x code when changing the schema.

-- 
Eduardo
