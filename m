Received: from eggs.gnu.org ([2001:4830:134:3::10]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGW9-0007zM-0i
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGW5-0002kt-TF
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:36:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eoGW5-0002kh-Oh
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:36:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21C448182D01
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 22:35:54 +0000 (UTC)
References: <1519148406-15006-1-git-send-email-thuth@redhat.com>
	<1519148406-15006-6-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5813dc8-5ec4-0aa1-074b-98547a49d8c6@redhat.com>
Date: Tue, 20 Feb 2018 16:35:49 -0600
MIME-Version: 1.0
In-Reply-To: <1519148406-15006-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] net: Remove the deprecated way of
 dumping network packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/20/2018 11:40 AM, Thomas Huth wrote:
> "-net dump" has been marked as deprecated since QEMU v2.10, since it
> only works with the deprecated 'vlan' parameter (or hubs). Network
> dumping should be done with "-object filter-dump" nowadays instead.
> Since nobody complained so far about the deprecation message, let's
> finally get rid of "-net dump" now.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

> +++ b/qapi/net.json
> @@ -39,8 +39,10 @@
>   #
>   # Add a network backend.
>   #
> -# @type: the type of network backend.  Current valid values are 'user', 'tap',
> -#        'vde', 'socket', 'dump' and 'bridge'
> +# @type: the type of network backend. Possible values in version
> +#        2.11: 'user', 'tap', 'vde', 'socket', 'hubport', 'bridge',
> +#              'dump', 'l2tpv3', 'netmap', 'vhost-user'
> +#        2.12: 'dump' dropped
>   #

That's a bit fuzzy, especially since the command has been around since 
0.14.  It might be easier to word it as:

@type: the type of network backend. Possible values are listed in 
NetClientDriver.

Then defer the actual listing by version...

> @@ -468,7 +453,7 @@
>   # Since: 2.7
>   ##
>   { 'enum': 'NetClientDriver',
> -  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
> +  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
>               'bridge', 'hubport', 'netmap', 'vhost-user' ] }

...to here (although this type only mentions 2.7 as its starting point). 
  (Hmm, I should see if it is worth reviving my attempted patches to 
properly QAPI-fy netdev_add into using a proper schema description - 
when I last proposed it, we ditched it at the last minute because of 
minor incompatibilities in parsing between a QAPI parse and the manual 
parse).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
