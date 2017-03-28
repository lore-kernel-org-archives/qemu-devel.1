Received: from eggs.gnu.org ([2001:4830:134:3::10]:44978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csm0D-0004vo-C6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csm0A-0001MP-AO
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csm0A-0001Lb-4d
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:57:14 -0400
References: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
	<20170327132454.GD28620@stefanha-x1.localdomain>
	<4712D8F4B26E034E80552F30A67BE0B1A40E6D@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <339080cc-c86d-93be-9c13-596eb43d56dd@redhat.com>
Date: Tue, 28 Mar 2017 09:57:09 +0200
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A40E6D@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Create libqemutrace.a for all trace.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>



On 27/03/2017 20:21, Xu, Anthony wrote:
>>> ./trace.o, ./qapi/trace.o and ./util/trace.o are added into
>>> libqemuutil.a  to avoid recursive dependencies between
>>> libqemuutil.a and libqemutrace.a.
>> Why would libqemutrace.a depend on libqemuutil.a?
> Each trace.c calls trace_event_register_group to register events, 
> trace_event_register_group is defined in trace/control.c , which 
> is linked into libqemuutil.a.

Ah:

util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
util-obj-y += control.o
util-obj-y += qmp.o

With the introduction of libqemutrace.a, I believe these should be moved
into libqemutrace.a.

Paolo

> 
>> Tracing code shouldn't call other QEMU code.  That would could create
>> infinite recursion when a trace event is fired.
> If all trace.o needed by libqemuutil.a are linked into libqemuutil.a, 
> libqemuutil.a will not depend on libqemutrace.a. This is what this patch 
> take to break the infinite recursion.
> 
> Or we can link trace/*.o to libqemutrace.a, hope it breaks the infinite 
> recursion. But trace/*.o may still depend on libqemuutil.a
> 
> Or we can just link all trace.o to libqemuutil.a.
