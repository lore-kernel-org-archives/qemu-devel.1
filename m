Received: from eggs.gnu.org ([2001:4830:134:3::10]:55311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPrth-0008Ki-DY
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPrtd-0008O9-Bp
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPrtd-0008Lc-5v
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DDAD7F415
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 14:55:16 +0000 (UTC)
Date: Tue, 27 Jun 2017 11:55:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627145507.GY12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498536619-14548-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/10] machine: export
 register_compat_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 12:10:10PM +0800, Peter Xu wrote:
[...]
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 1e5c928..4ab4359 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -208,6 +208,29 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
>                                      Property *prop, const char *value);
>  
>  /**
> + * register_compat_prop:
> + *
> + * Register internal (not user-provided) global property, changing the
> + * default value of a given property in a device type.  This can be used
> + * for enabling machine-type compatibility or for enabling
> + * accelerator-specific defaults in devices.
> + *
> + * The property values set using this function must be always valid and
> + * never report setter errors, as they property have

Typo (my fault, sorry).  It should be "the property have", or "the
property will have".

With this fixed (which may be done manually by the maintainer when
applying):

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> + * GlobalProperty::errp set to &error_abort.
> + *
> + * User-provided global properties should override internal global
> + * properties, so callers of this function should ensure that it is
> + * called before user-provided global properties are registered.
> + *
> + * @driver: Device type to be affected
> + * @property: Property whose default value is going to be changed
> + * @value: New default value for the property
> + */
> +void register_compat_prop(const char *driver, const char *property,
> +                          const char *value);
> +
> +/**
>   * qdev_property_add_static:
>   * @dev: Device to add the property to.
>   * @prop: The qdev property definition.
> -- 
> 2.7.4
> 

-- 
Eduardo
