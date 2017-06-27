Received: from eggs.gnu.org ([2001:4830:134:3::10]:52896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPtlH-0007PJ-9L
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPt05-00008b-JD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:06:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170626165832.32mzemh4jiwpquo4@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
	<20170626165832.32mzemh4jiwpquo4@postretch>
Date: Tue, 27 Jun 2017 18:05:55 +0200
Message-ID: <w5160fhza8s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 4/8] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Mon 26 Jun 2017 06:58:32 PM CEST, Manos Pitsidianakis wrote:
> On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
>>On Fri, Jun 23, 2017 at 03:46:56PM +0300, Manos Pitsidianakis wrote:
>>> +static bool throttle_group_exists(const char *name)
>>> +{
>>> +    ThrottleGroup *iter;
>>> +    bool ret = false;
>>> +
>>> +    qemu_mutex_lock(&throttle_groups_lock);
>>
>>Not sure if this lock or the throttle_groups list are necessary.

As Manos says accesses to the throttle_groups list need to be locked.

What I don't like at first sight is the code duplication in
throttle_group_incref() and throttle_group_obj_complete().

>>Have you seen iothread.c:qmp_query_iothreads()?  All objects are put
>>into a container (the parent object), so you can just iterate over its
>>children.  There's no need for a separate list because QOM already has
>>all the objects.

I haven't looked into this yet but it could be a solution.

Berto
