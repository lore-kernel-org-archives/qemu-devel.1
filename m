Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C897DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9332220684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+wow/BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9332220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5mX-00044T-O1
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iO5WH-0007tk-4j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iO5WD-0007zj-KL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:45:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iO5WD-0007yV-FW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572032704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBV6TDrwNZpQJjS3MeYsysX3f3Xdq1uPW8dVeYUqUbY=;
 b=f+wow/BK99Dkn1JU7qo7ZzCmupjrvyWO5X+ElJjNS5G7Y1d+Ejmf4hm8A/GL8qnqCaNR3b
 lZIup+HAPSIozF/KvZTjCt5/fsW2SsbqXhafATnxnDze3L+JjA09pIfWDAcK4C7iJbElTy
 HBmj9ft4GBS07+Ul8fzpi32TyBX0QGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-oR62r2z3Oha-H1lZhBdYDg-1; Fri, 25 Oct 2019 15:45:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF84800D41;
 Fri, 25 Oct 2019 19:44:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 333155D9CA;
 Fri, 25 Oct 2019 19:44:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A758F1138619; Fri, 25 Oct 2019 21:44:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency and
 bandwidth information
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
 <20191023172854.42c495d5@redhat.com>
 <9e30d8fe-7274-4ee8-3c4b-64c370141358@intel.com>
 <20191025152720.4068bfae@redhat.com>
Date: Fri, 25 Oct 2019 21:44:50 +0200
In-Reply-To: <20191025152720.4068bfae@redhat.com> (Igor Mammedov's message of
 "Fri, 25 Oct 2019 15:27:20 +0200")
Message-ID: <87wocsobil.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oR62r2z3Oha-H1lZhBdYDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>, "Du,
 Fan" <fan.du@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> On Fri, 25 Oct 2019 14:33:53 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
>
>> On 10/23/2019 11:28 PM, Igor Mammedov wrote:
>> > On Sun, 20 Oct 2019 19:11:19 +0800
>> > Tao Xu <tao3.xu@intel.com> wrote: =20
>> [...]
>> >> +#
>> >> +# @access-bandwidth: access bandwidth (MB/s)
>> >> +#
>> >> +# @read-bandwidth: read bandwidth (MB/s)
>> >> +#
>> >> +# @write-bandwidth: write bandwidth (MB/s) =20
>> > I think units here are not appropriate, values stored in fields are
>> > minimal base units only and nothing else (i.e. ps and B/s)
>> >  =20
>> Eric suggest me to drop picoseconds. So here I can use ns. For=20
>> bandwidth, if we use B/s here, does it let user or developer to=20
>> misunderstand that the smallest unit is B/s ?
>
> It's not nanoseconds or MB/s stored in theses fields, isn't it?
> I'd specify units in which value is stored or drop units altogether.
>
> Maybe Eric and Markus can suggest a better way to describe fields.

This isn't review (yet), just an attempt to advise more quickly on
general QAPI/QMP conventions.

Unit prefixes like Mebi- are nice for humans, because 1MiB is clearer
than 1048576B.

QMP is for machines.  We eschew unit prefixes and unit symbols there.
The unit is implied.  Unit prefixes only complicate things.  Machines
can deal with 1048576 easily.  Also dealing 1024Ki and 1Mi is additional
work.  We therefore use JSON numbers for byte counts, not strings with
units.

The general rule is "always use the plainest implied unit that would
do."  There are exceptions, mostly due to review failure.

Byte rates should be in bytes per second.

For time, we've made a godawful mess.  The plainest unit is clearly the
second.  We commonly need sub-second granularity, though.
Floating-point seconds are unpopular for some reason :)  Instead we use
milli-, micro-, and nanoseconds, and even (seconds, microseconds) pairs.

QAPI schema documentation describes both the generated C and the QMP
wire protocol.  It must be written with the implied unit.  If you send a
byte rate in bytes per second via QMP, that's what you document.  Even
if a human interface lets you specify the byte rate in MiB/s.

Does this make sense?

>> >>   @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{la=
stcpu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>> >>   @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{=
lastcpu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>> >>   @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D=
@var{distance}
>> >>   @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-i=
d=3D@var{y}][,thread-id=3D@var{z}]
>> >> +@itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hier=
archy=3D@var{str},data-type=3D@var{str}[,latency=3D@var{lat}][,bandwidth=3D=
@var{bw}] =20
>> >                                                                       =
         ^^^                 ^^^
>> > Using the same 'str' for 2 different enums is confusing.
>> > Suggest for 1st use 'level' and for the second just 'type'
>> >  =20
>> Ok
>>=20
>> >>   @findex -numa
>> >>   Define a NUMA node and assign RAM and VCPUs to it.
>> >>   Set the NUMA distance from a source node to a destination node.
>> >> +Set the ACPI Heterogeneous Memory Attributes for the given nodes.
>> >>  =20
>> >>   Legacy VCPU assignment uses @samp{cpus} option where
>> >>   @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
>> >> @@ -256,6 +259,50 @@ specified resources, it just assigns existing re=
sources to NUMA
>> >>   nodes. This means that one still has to use the @option{-m},
>> >>   @option{-smp} options to allocate RAM and VCPUs respectively.
>> >>  =20
>> >> +Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Info=
rmation
>> >> +between initiator and target NUMA nodes in ACPI Heterogeneous Attrib=
ute Memory Table (HMAT).
>> >> +Initiator NUMA node can create memory requests, usually including on=
e or more processors. =20
>> > s/including/it has/
>> >  =20
>> >> +Target NUMA node contains addressable memory.
>> >> +
>> >> +In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{str} of=
 'hierarchy'
>> >> +is the memory hierarchy of the target NUMA node: if @var{str} is 'me=
mory', the structure
>> >> +represents the memory performance; if @var{str} is 'first-level|seco=
nd-level|third-level',
>> >> +this structure represents aggregated performance of memory side cach=
es for each domain.
>> >> +@var{str} of 'data-type' is type of data represented by this structu=
re instance:
>> >> +if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' laten=
cy(nanoseconds) =20
>> > is nanoseconds is right here? Looking at previous patches default valu=
e of suffix-less
>> > should be picoseconds. I'd just drop '(nanoseconds)'. User will use ap=
propriate suffix.
>> >  =20
>> OK, I will drop it.
>> >> +or 'access|read|write' bandwidth(MB/s) of the target memory; if 'hie=
rarchy' is =20
>> > ditto (MB/s), probably should be Bytes/s for default suffix-less value
>> > (well, I'm not sure how to express it better)
>> >  =20
>>=20
>> But last version, we let !QEMU_IS_ALIGNED(node->bandwidth, MiB) as error=
.
> it's alignment requirement and it doesn't mean that value could not be
> represented in bytes/s.
> And it is bytes/s if suffix isn't used.
>
> As for alignment and precision of values you probably need to document
> expectations here as well.
>
>> >> +'first-level|second-level|third-level', 'data-type' is 'access|read|=
write' hit latency
>> >> +or 'access|read|write' hit bandwidth of the target memory side cache=
.
>> >> +
>> >> +@var{lat} of 'latency' is latency value, the possible value and unit=
s are
>> >> +NUM[ps|ns|us] (picosecond|nanosecond|microsecond), the recommended u=
nit is 'ns'. @var{bw}
>> >> +is bandwidth value, the possible value and units are NUM[M|G|T], mea=
n that =20
>> >  =20
>> >> +the bandwidth value are NUM MB/s, GB/s or TB/s. Note that max NUM is=
 65534,
>> >> +if NUM is 0, means the corresponding latency or bandwidth informatio=
n is not provided.
>> >> +And if input numbers without any unit, the latency unit will be 'ps'=
 and the bandwidth
>> >> +will be MB/s. =20
>> >   1st: above is applicable to both bw and lat values and should be doc=
umented as such
>> >   2nd: 'max NUM is 65534' when different suffixes is fleeting target,
>> >        spec says that entry with 0xFFFF is unreachable, so how about d=
ocumenting
>> >        unreachable value as 0xFFFFFFFFFFFFFFFF (then CLI parsing code =
will
>> >        exclude it from range detection and acpi table building code tr=
anslate it
>> >        to internal 0xFFFF it could fit into the tables)
>> >  =20
>>=20
>> If we input 0xFFFFFFFFFFFFFFFF, qemu will raise error that parameter=20
>> expect a size value.
>
> opts_type_size() can't handle values >=3D 0xfffffffffffffc00
>
> commit f46bfdbfc8f (util/cutils: Change qemu_strtosz*() from int64_t to u=
int64_t)
>
> so behavior would change depending on if the value is parsed by CLI (size=
) or QMP (unit64) parsers.

Do these values matter?  Is there a use case for passing
18446744073709550593 via CLI?

> we can cannibalize 0x0 as the unreachable value and an absent bandwidth/l=
at option
> for not specified case.
> It would be conflicting with matrix [1] values in spec, but CLI/QMP deals=
 with
> absolute values which are later processed into HMAT substructure.
>
> Markus,
> Can we make opts_type_size() handle full range of uint64_t?

Maybe.

> 1)
> ACPI 6.3 spec:
> 5.2.27.4 System Locality Latency and Bandwidth Information Structure


