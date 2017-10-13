Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e30mX-00027Z-Ta
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e30mS-0008Mw-8m
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:17:45 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:57280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1e30mR-0008Hu-SY
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:17:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 13 Oct 2017 16:16:54 +0200
Message-ID: <w51fuanjfop.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v13 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Mon 02 Oct 2017 04:33:28 PM CEST, Pradeep Jagadeesh wrote:
> This patch factors out code to use the ThrottleLimits
> structure.

>  { 'struct': 'BlockIOThrottle',
> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
> -            '*bps_max': 'int', '*bps_rd_max': 'int',
> -            '*bps_wr_max': 'int', '*iops_max': 'int',
> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> -            '*iops_size': 'int', '*group': 'str' } }
> +  'base': 'ThrottleLimits',
> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }

So BlockIOThrottle used to have parameters named bps_rd and iops_wr, and
after this patch they become bps-read and iops-write. This breaks the
API completely, as you can see if you run e.g. iotest 129:

AssertionError: failed path traversal for "return" in "{u'error': {u'class': u'GenericError', u'desc': u"Parameter 'iops_rd' is unexpected"}}"

I just checked previous versions of the series and I see that Manos
already warned you of this in v11:

   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04698.html

Berto
