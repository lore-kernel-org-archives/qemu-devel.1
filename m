Received: from eggs.gnu.org ([2001:4830:134:3::10]:49386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRNGh-0002yE-Mv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRNGg-0005vN-QN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRNGg-0005ty-JF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:05:02 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E00D129216
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:05:02 +0000 (UTC)
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
	<6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
	<20170111174045.GT12072@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ff77c17-5516-e967-27ec-6fb3bf2160d4@redhat.com>
Date: Wed, 11 Jan 2017 19:05:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170111174045.GT12072@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org



On 11/01/2017 18:40, Daniel P. Berrange wrote:
> On Wed, Jan 11, 2017 at 06:34:40PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 11/01/2017 18:16, Daniel P. Berrange wrote:
>>> I've been trying to get such relative includes to work most of today
>>> and not having much luck. The problem is that while it works in 95%
>>> of the time, there are some source files and header files which need
>>> to include trace.h files not in their local directory
>>
>> Which are they?  I wouldn't have expected that to happen.
>=20
> It is indirect - particularly Xen - include/hw/xen/xen_common.h hsa
> some trace points and that is included from many different source
> files. Likewise with include/exec/cpu_ldst_template.h

I see.  Yeah, this gets tricky for template-style headers.  (In the case
of include/hw/xen/xen_common.h I would just move the functions to a .c
file, but that's a separate thing and the template-style headers are a
real problem).

>>> and we can't
>>> use relative includes for that, since the relative include gets
>>> resolved wrt the source file doing the #include, but the trace.h
>>> file is in $BUILD_DIR.
>>
>> Why would #include "../foo/trace.h" be resolved against the source
>> file's path only, and not against all -I directories?
>=20
> If we have a plain "../trace.h", then it can end up hitting the
> wrong file, because there are many -I dirs listed and most of
> them contain a trace.h file, so if it matches on the 2nd -I
> dir and you need the one from the 3rd -I dir it gets "fun".

Hmm, I would have expected only the .o directory to have a ../trace.h.
But again it doesn't help for template-style headers where ../trace.h is
resolved according to the including file, not the included file.

A weird idea: what about doing

    -DGENERATED_TRACERS_H=3D\"hw/scsi/generated-tracers.h\"

and then having

     #ifdef GENERATED_TRACE_H
     #include GENERATED_TRACE_H
     #endif

in include/trace.h?

Then you can use full include path for special cases such as
include/hw/xen/xen_common.h, but the common case is handled directly
with just

     #include "trace.h"

which refers to $(srcdir)/include/trace.h? (Take the above with a grain
of salt because I haven't reviewed the patches closely).

Paolo

> Having all the trace.h files included with path from the root
> is alot simpler to understand IMHO than just plain "trace.h"
> and hoping the -I order is going to ensure the right one is
> found
