Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0nzi-0007Ex-5b
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0nzf-0004oy-JV
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:41:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36125
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d0nzf-0004oo-Db
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:41:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JBceN0074580
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:41:54 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29x744rdyw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:41:53 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 19 Apr 2017 12:41:52 +0100
Date: Wed, 19 Apr 2017 13:41:47 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170419134147.458e4eb7.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add
 guest-network-get-interface-stat command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, 20 Apr 2017 00:57:08 +0800
ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..60111dc 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,37 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +##
> +# @GuestNetworkInterfaceStat:
> +#
> +# @rx_bytes: received bytes of interface
> +#
> +# @rx_packets: received packets of interface
> +#
> +# @rx_errs: received error packets of interface
> +# @rx_drop: received drop packets of interface
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestNetworkInterfaceStat',
> +  'data': {'rx_bytes': 'uint64',
> +            'rx_packets': 'uint64',
> +            'rx_errs': 'uint64',
> +            'rx_drop': 'uint64',
> +            'tx_bytes': 'uint64',
> +            'tx_packets': 'uint64',
> +            'tx_errs': 'uint64',
> +            'tx_drop': 'uint64'
> +           } }
> +##
> +# @guest-network-get-interface-stat:
> +#
> +# Get list of interface stat
> +#
> +# Returns: List of GuestNetworkInterfaceStat on success.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-network-get-interface-stat',
> +  'data':    {'bus': 'int64', 'slot': 'int64', 'function': 'int64','netname':'str'},
> +  'returns': ['GuestNetworkInterfaceStat'] }

Disregarding the question whether this command should be added to the
guest agent (I'll leave that to others to discuss), I don't think it's
a good idea to enshrine pci identifiers here, as it means that we would
need to add a new interface for every non-pci network device.

Can you use a more general device identifier interface? It's fine to
only support pci for now (as that is likely your use case anyway), but
there should be a way to extend this in the future.
